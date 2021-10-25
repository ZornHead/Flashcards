import 'package:flutter/material.dart';
import 'package:flutter_app/constants/clipImge.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartScreen extends StatefulHookWidget {
  static const String id = 'strt';

  @override
  _StartScreenState createState() => _StartScreenState();
}

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

class _StartScreenState extends State<StartScreen> {
  final AuthController authController = Get.find(tag: 'auth_controller');
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Get.put(ScalerConfig(context), tag: 'scaler');
    ScalerConfig scaler = Get.find(tag: 'scaler');

    final boxWidth = MediaQuery.of(context).size.width;
    final boxHeight = boxWidth * (471.0 / 693.0);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            currentIndex != images.length - 1
                ? Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 30, top: 30),
                    child: InkWell(
                      onTap: () {
                        pageController.animateToPage(images.length - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text("Skip",
                          style: textStyle(
                              fontSize: scaler.scalerT(18),
                              color: DayTheme.textColor,
                              textDecoration: TextDecoration.underline)),
                    ),
                  )
                : Container(
                    child: SizedBox(
                      height: scaler.scalerV(60.0),
                    ),
                  ),
            SizedBox(
              height: scaler.scalerV(80.0),
            ),
            Expanded(
              child: PageView.builder(
                  onPageChanged: (val) {
                    setState(() {
                      currentIndex = val;
                    });
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
                          height: scaler.scalerV(64.0),
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
            SizedBox(
              height: scaler.scalerV(10.0),
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
            currentIndex != images.length - 1
                ? Container(
                    padding: EdgeInsets.fromLTRB(
                        0, scaler.scalerV(50.0), 0, scaler.scalerV(50.0)))
                : Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          scaler.scalerH(60.0),
                          scaler.scalerV(20.0),
                          scaler.scalerH(60.0),
                          scaler.scalerV(40.0)),
                      child: Click(
                        onPressed: () {
                          authController.onBoarding();
                        },
                        text: "GET STARTED",
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
