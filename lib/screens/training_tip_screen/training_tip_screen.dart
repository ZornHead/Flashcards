import 'package:flutter/material.dart';
import 'package:flutter_app/constants/clipImge.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class TrainingTipScreen extends HookWidget {
  static const String id = 'taining';

  final List<String> images = <String>[
    'assets/images/Kimura.png',
    'assets/images/Arm.png',
    'assets/images/Triangle.png',
    'assets/images/Omoplata.png',
    'assets/images/Kimura.png',
    'assets/images/Triangle.png',
  ];

  final List<String> texts = <String>[
    'Some text here',
    'Some text here2',
    'Some text here3',
    'Some text here4',
    'Some text here5',
    'Some text here6',
  ];

  final List<String> description = <String>[
    'Artificial intelligence spaces your reviews for optimal retention, because the most useful video is the one playing in your head.',
    'Choose Mental Practice and create detailed mental images of each technique.',
    'Choose Physical Practice and do the techniques with a partner.',
    'Use the pause and slowdown features to analyze every detail.',
    'You can also browse individual categories and techniques.',
    'Experiment with the app. You can always clear your input for a start fresh.',
  ];

  final AuthController authController = Get.find(tag: 'auth_controller');

  int currentIndex = 0;

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final boxWidth = MediaQuery.of(context).size.width;
    final boxHeight = boxWidth * (471.0 / 693.0);
    return Scaffold(
      appBar: header(context, text: "Training Tips"),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                onPageChanged: (val) {
                  currentIndex = val;
                },
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (cxt, i) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      ClipPath(
                        clipper: ClipImage(),
                        child: Image(
                          image: AssetImage(images[i]),
                          width: boxWidth,
                          height: boxHeight,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: scaler.scalerV(70.0),
                      ),
                      Text(
                        texts[i],
                        style: textStyle(
                            fontSize: scaler.scalerT(26.0),
                            color: DayTheme.primaryColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(scaler.scalerH(55.0),
                            scaler.scalerV(5.0), scaler.scalerH(55.0), 0),
                        child: Text(
                          description[i],
                          style: textStyle(fontSize: scaler.scalerT(16.0)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  );
                }),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: images.length,
            onDotClicked: (int index) {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            effect: SlideEffect(
                spacing: 8.0,
                radius: 8.0,
                dotWidth: 12.0,
                dotHeight: 12.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 0.5,
                dotColor: Colors.grey,
                activeDotColor: Colors.red),
          ),
          SizedBox(
            height: scaler.scalerV(130.0),
          ),
        ],
      ),
    );
  }
}
