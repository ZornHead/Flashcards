import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final ScalerConfig scaler = Get.find(tag: 'scaler');

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class DayTheme {
  static const h1 = 96.0;
  static const h2 = 60.0;
  static const h3 = 48.0;
  static const h4 = 34.0;
  static const h5 = 24.0;
  static const h6 = 20.0;
  static const body = 16.0;
  static const paragraph = 14.0;
  static const caption = 12.0;
  static const overline = 10.0;
  static final primaryColor = HexColor('#FF0000');
  static final primaryMaterialColor = MaterialColor(0xFFFF0000, color);
  static final textColor = HexColor('#888888');
  static final secTextColor = HexColor('#DBDBDB');
  static final progressBarColor = HexColor('#8DE496');
  static final pinkColor = HexColor('#faf0f0');
}

TextStyle textStyle(
    {Color color,
    double fontSize,
    FontWeight fontWeight,
    double height,
    TextDecoration textDecoration}) {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
          height: height));
}

AppBar header(context, {String text, Function onTap}) {
  return AppBar(
      backgroundColor: DayTheme.primaryColor,
      centerTitle: true,
      title: Text(
        text,
        style: textStyle(fontWeight: FontWeight.w600),
      ),
      brightness: Brightness.dark,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onTap ??
            () {
              Navigator.pop(context);
            },
      ));
}

AppBar authheader(context, {String text}) {
  return AppBar(
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: scaler.scalerV(32.0)),
        child: Text(text,
            style: textStyle(
                color: DayTheme.primaryColor,
                fontSize: scaler.scalerT(28.0),
                fontWeight: FontWeight.w600)),
      ),
      toolbarHeight: scaler.scalerV(80.0),
      backgroundColor: Colors.white10,
      elevation: 0,
      brightness: Brightness.light,
      leading: IconButton(
        icon: Padding(
          padding: EdgeInsets.only(
              left: scaler.scalerH(18.0), top: scaler.scalerV(30.0)),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
}

void popupDialog(context,
    {String text, text1, text2, Function onTap, bool popOnce = false}) {
  showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      barrierColor: Colors.white,
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Container(
            width: scaler.scalerH(325.0),
            height: scaler.scalerV(285.0),
            child: Center(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (!popOnce) {
                            if (Navigator.of(buildContext).canPop()) {
                              Navigator.of(buildContext).pop();
                            }
                          }
                          if (Navigator.of(buildContext).canPop()) {
                            Navigator.of(buildContext).pop();
                          }
                          onTap();
                        },
                        child: Icon(
                          Icons.clear,
                          color: DayTheme.textColor,
                          size: scaler.scalerV(20.0),
                        ),
                      )),
                  SizedBox(
                    height: scaler.scalerV(60.0),
                  ),
                  Icon(
                    Icons.task_alt_rounded,
                    color: DayTheme.primaryColor,
                    size: scaler.scalerV(64.0),
                  ),
                  SizedBox(
                    height: scaler.scalerV(20.0),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle(
                        fontSize: scaler.scalerT(16),
                        color: DayTheme.textColor),
                  ),
                  SizedBox(
                    height: scaler.scalerV(15.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: textStyle(
                          fontSize: scaler.scalerT(14.0),
                          color: DayTheme.textColor),
                      children: [
                        TextSpan(
                          text: text1,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed(LoginScreen.id);
                            },
                          text: text2,
                          style: textStyle(
                            fontWeight: FontWeight.w600,
                            color: DayTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void showAlertDialog(
  BuildContext context, {
  String title,
  String text,
  String no = "No",
  String yes = "Yes",
  Function onPressedNo,
  Function onPressedYes,
}) {
  showDialog(
    barrierColor: Colors.white,
    context: context,
    builder: (BuildContext buildContext) {
      return AlertDialog(
        title: Text(
          title,
          style: textStyle(
              fontSize: scaler.scalerT(18.0), fontWeight: FontWeight.w500),
        ),
        content: Text(
          text,
          style: textStyle(fontSize: scaler.scalerT(14.0)),
        ),
        actions: [
          TextButton(
              child: Text(no),
              onPressed: () {
                Navigator.of(buildContext).pop();
                if (onPressedNo != null) {
                  onPressedNo();
                }
              }),
          TextButton(
              child: Text(yes),
              onPressed: () {
                Navigator.of(buildContext).pop();
                if (onPressedYes != null) {
                  onPressedYes();
                }
              }),
        ],
      );
    },
  );
}

void popupDialogButton(context,
    {String text, btext, brtext, Function onTap, onPressed, double h}) {
  showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      barrierColor: Colors.white,
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Container(
            width: scaler.scalerH(300.0),
            height: scaler.scalerV(275.0),
            child: Center(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, scaler.scalerH(05), scaler.scalerV(10)),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.clear,
                              color: DayTheme.textColor,
                              size: scaler.scalerV(20.0),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: scaler.scalerV(20.0),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textStyle(
                          fontSize: scaler.scalerT(16),
                          color: DayTheme.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaler.scalerH(35.0)),
                      child: Click(
                        text: btext,
                        onPressed: onPressed,
                        height: scaler.scalerV(45.0),
                        color: DayTheme.progressBarColor,
                        fontSize: scaler.scalerT(12.0),
                      ),
                    ),
                    SizedBox(
                      height: scaler.scalerV(15.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaler.scalerH(35.0)),
                      child: Click(
                        text: brtext,
                        onPressed: onTap,
                        height: scaler.scalerV(47.0),
                        fontSize: scaler.scalerT(12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
