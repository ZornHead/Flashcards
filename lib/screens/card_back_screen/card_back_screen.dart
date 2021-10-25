import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/back_card_controller.dart';
import 'package:flutter_app/screens/smartmix_card_fronts_screen%20/smartmix_card_fronts_screen%20.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CardBack extends StatefulHookWidget {
  static const String id = 'cardback';

  @override
  _CardBackState createState() => _CardBackState();
}

class _CardBackState extends State<CardBack> {
  final BackCardController backController =
      Get.put(BackCardController(), tag: 'back_controller');

  VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;

    final cardId = useState(args['id']);
    final practiceType = useState(args['type'] == 'mental' ? 0 : 1);
    final practiceTypes = useState(args['type']);
    moveOn() {
      args['Smart Mix'] == 'Smart Mix'
          ? backController.smartMixmoveOn(
              practiceType: practiceType.value.toString(),
              cardId: cardId.value,
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'Smart Mix': args['Smart Mix'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              })
          : backController.categorymoveOn(
              practiceType: practiceType.value.toString(),
              cardId: cardId.value,
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'categoryname': args['categoryname'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              });
    }

    print('type = ${args['type']}');

    needsWork() {
      args['Smart Mix'] == 'Smart Mix'
          ? backController.smartmixwork(
              practiceTypes: practiceTypes.value,
              cardId: cardId.value,
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'Smart Mix': args['Smart Mix'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              })
          : backController.categorywork(
              practiceTypes: practiceTypes.value,
              cardId: cardId.value,
              onSuccess: (title, id, video, content, image) {
                Navigator.of(context)
                    .pushNamed(SmartMixCardFronts.id, arguments: {
                  'title': title,
                  'image': image,
                  'content': content,
                  'id': id,
                  'video': video,
                  'categoryname': args['categoryname'],
                  'type': args['type'],
                  'typeTitle': args['typeTitle'],
                });
              });
    }

    print('cardId= ${cardId.value}');
    print('id = ${args['id']}');
    final boxWidth =
        MediaQuery.of(context).size.width - scaler.scalerH(26.0) * 2;
    final boxHeight = boxWidth * (182.05 / 324.0);
    final video = args['video'];
    controller = VideoPlayerController.network(video
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        );
    controller.addListener(() {
      if (controller.value.hasError) {
        SnackbarHandler.errorToast("No video available", "");
      }
    });
    final flickManager = FlickManager(
        autoInitialize: true,
        autoPlay: true,
        videoPlayerController: controller);

    return WillPopScope(
      onWillPop: () async {
        controller.dispose();
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: header(
            context,
            text: args['title'],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(scaler.scalerH(25),
                scaler.scalerV(20.0), scaler.scalerH(25), 0),
            child: Column(
              children: [
                Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    constraints: BoxConstraints.expand(
                      width: boxWidth,
                      height: boxHeight,
                    ),
                    child: FlickVideoPlayer(flickManager: flickManager)),
                SizedBox(
                  height: scaler.scalerV(35.0),
                ),
                Text(
                  args['content'],
                  style: textStyle(
                      fontSize: scaler.scalerT(16.0),
                      color: DayTheme.textColor),
                  textScaleFactor: 1.05,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
              scaler.scalerH(25),
              scaler.scalerV(50.0),
              scaler.scalerH(25),
              scaler.scalerV(20.0),
            ),
            height: scaler.scalerV(120.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(() => Click(
                        loading: backController.loading.value,
                        text: "NEEDS WORK",
                        color: DayTheme.textColor,
                        fontSize: scaler.scalerT(12.0),
                        onPressed: needsWork,
                      )),
                ),
                SizedBox(
                  width: scaler.scalerH(15),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(() => Click(
                        loading: backController.isloading.value,
                        text: "MOVE ON",
                        color: DayTheme.progressBarColor,
                        fontSize: scaler.scalerT(12.0),
                        onPressed: moveOn,
                      )),
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    print("video stop");
    super.dispose();
  }
}
