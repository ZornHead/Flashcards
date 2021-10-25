import 'package:flutter/material.dart';
import 'package:flutter_app/constants/clipImge.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/card_back_screen/card_back_screen.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class SmartMixCardFronts extends HookWidget {
  static const String id = 'smartfrontcards';
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    dynamic arged = ModalRoute.of(context).settings.arguments;

    final boxWidth = MediaQuery.of(context).size.width;
    final boxHeight = boxWidth * (471.0 / 693.0);
    print('type = ${arged['type']}');
    print('id=${arged['id']}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(context, onTap: () {
        Navigator.of(context).pushNamed(MentalPracticeScreen.id, arguments: {
          'type': arged['type'],
          'typeTitle': arged['typeTitle']
        });
      }, text: arged['title']),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamed(MentalPracticeScreen.id, arguments: {
            'type': arged['type'],
            'typeTitle': arged['typeTitle']
          });
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: boxHeight,
                width: boxWidth,
                child: ClipPath(
                  clipper: ClipImage(),
                  child: arged['image'] != null
                      ? Image.network(
                          arged['image'],
                          fit: BoxFit.cover,
                        )
                      : "",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    scaler.scalerH(20.0),
                    scaler.scalerV(90.0),
                    scaler.scalerH(20.0),
                    scaler.scalerH(05.0)),
                child: Text(
                  arged['title'],
                  textAlign: TextAlign.center,
                  style: textStyle(
                      height: scaler.scalerV(1.2),
                      color: DayTheme.primaryColor,
                      fontSize: scaler.scalerT(32.0),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                arged['Smart Mix'] == 'Smart Mix'
                    ? arged['Smart Mix']
                    : arged['categoryname'],
                textAlign: TextAlign.center,
                style: textStyle(
                  color: DayTheme.textColor,
                  fontSize: scaler.scalerT(16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(scaler.scalerH(45.0),
                    scaler.scalerV(90.0), scaler.scalerH(45.0), 0),
                child: Click(
                    text: 'SHOW ANSWER',
                    onPressed: () {
                      Navigator.of(context).pushNamed(CardBack.id, arguments: {
                        'title': arged['title'],
                        'video': arged['video'],
                        'image': arged['image'],
                        'content': arged['content'],
                        'id': arged['id'],
                        'type': arged['type'],
                        'typeTitle': arged['typeTitle'],
                        'Smart Mix': arged['Smart Mix'],
                        'categoryname': arged['categoryname'],
                        'progress': arged['progress']
                      });
                    }),
              ),
              SizedBox(
                height: scaler.scalerV(30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
