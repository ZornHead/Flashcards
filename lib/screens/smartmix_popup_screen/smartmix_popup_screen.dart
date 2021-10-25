import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/back_card_controller.dart';
import 'package:flutter_app/screens/browse_cards_screen/browse_cards_screen.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:get/get.dart';

smartmixPopupScreen(BuildContext context, categoryname, categoryBrowse, type,
    typeTitle, smartmix) {
  final BackCardController backController =
      Get.put(BackCardController(), tag: 'back_controller');
  print(smartmix.progress);

  showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      barrierColor: Colors.white,
      context: context,
      builder: (buildContext) {
        return WillPopScope(
          onWillPop: () {
            Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                arguments: {'type': type, 'typeTitle': typeTitle});
            return Future.value(false);
          },
          child: AlertDialog(
            backgroundColor: DayTheme.pinkColor.withOpacity(0),
            actions: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.78, 0.0],
                    colors: [Colors.white, DayTheme.pinkColor],
                  ),
                ),
                child: Container(
                  width: scaler.scalerH(325.0),
                  height: scaler.scalerV(350.0),
                  child: Center(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, scaler.scalerV(20),
                              scaler.scalerH(20), scaler.scalerV(10)),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      MentalPracticeScreen.id,
                                      arguments: {
                                        'type': type,
                                        'typeTitle': typeTitle
                                      });
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: DayTheme.textColor,
                                  size: scaler.scalerV(20.0),
                                ),
                              )),
                        ),
                        Text(
                          categoryname,
                          textAlign: TextAlign.center,
                          style: textStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.scalerT(16),
                              color: DayTheme.textColor),
                        ),
                        SizedBox(
                          height: scaler.scalerV(15.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: scaler.scalerH(40.0)),
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                Click(
                                  text: 'STUDY',
                                  onPressed: () {
                                    smartmix.progress != '100'
                                        ? Navigator.of(context).pushNamed(
                                            CardFronts.id,
                                            arguments: {
                                                categoryname: "Smart Mix",
                                                'title': categoryBrowse.title,
                                                'image': categoryBrowse.image,
                                                'content':
                                                    categoryBrowse.content,
                                                'video': categoryBrowse.video,
                                                'id': categoryBrowse.id,
                                                'type': type,
                                                'typeTitle': typeTitle,
                                                'progress': smartmix.progress
                                              })
                                        : SnackbarHandler.normalToast(
                                            "All Cards Used", '');
                                  },
                                  height: scaler.scalerV(45.0),
                                  color: DayTheme.progressBarColor,
                                  fontSize: scaler.scalerT(12.0),
                                ),
                                SizedBox(
                                  height: scaler.scalerV(15.0),
                                ),
                                Click(
                                  text: 'BROWSE',
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        BrowseCardScreen.id,
                                        arguments: {
                                          categoryname: "Smart Mix",
                                          'type': type,
                                          'typeTitle': typeTitle,
                                          'progress': smartmix.progress
                                        });
                                  },
                                  color: DayTheme.textColor,
                                  height: scaler.scalerV(45.0),
                                  fontSize: scaler.scalerT(12.0),
                                ),
                                SizedBox(
                                  height: scaler.scalerV(15.0),
                                ),
                                Click(
                                  text: 'CLOSE',
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        MentalPracticeScreen.id,
                                        arguments: {
                                          'type': type,
                                          'typeTitle': typeTitle
                                        });
                                  },
                                  height: scaler.scalerV(45.0),
                                  color: DayTheme.primaryColor,
                                  fontSize: scaler.scalerT(12.0),
                                ),
                                SizedBox(
                                  height: scaler.scalerV(30.0),
                                ),
                                Click(
                                  text: 'RESET PROGRESS',
                                  onPressed: () {
                                    popupDialogButton(context,
                                        text:
                                            "Are you sure to reset all progress.",
                                        h: scaler.scalerV(40.0),
                                        btext: "YES",
                                        onPressed: () {
                                          backController.restProgress(
                                              type: type,
                                              onSuccess: () {
                                                popupDialog(
                                                  context,
                                                  text:
                                                      "Progress Reset Successful",
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .pushNamed(
                                                          MentalPracticeScreen
                                                              .id,
                                                          arguments: {
                                                        'type': type,
                                                        'typeTitle': typeTitle
                                                      }),
                                                  popOnce: true,
                                                );
                                              });
                                        },
                                        brtext: "NO, DON'T RESET",
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        });
                                  },
                                  height: scaler.scalerV(47.0),
                                  fontSize: scaler.scalerT(12.0),
                                ),
                                SizedBox(
                                  height: scaler.scalerV(10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
