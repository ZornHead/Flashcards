import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/create_password_screen/create_password_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PasswordOtpScreen extends HookWidget {
  static String id = 'passwordotp';
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    final otp = useState("");

    passwordVerifyOtp() {
      authController.passwordVerifyOtp(
          email: args['email'],
          otp: otp.value,
          onSuccess: (String token) {
            Navigator.of(context).popAndPushNamed(
              CreatePasswordScreen.id,
              arguments: {'token': token},
            );
          });
    }

    resendOtp() {
      authController.resendOtp(email: args['email']);
    }

    return Scaffold(
      appBar: authheader(context, text: ""),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: scaler.scalerV(35.0)),
            Text(
              'OTP Verification',
              style: textStyle(
                  color: DayTheme.primaryColor,
                  fontSize: scaler.scalerT(26.0),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: scaler.scalerV(30.0),
            ),
            Text(
              "Please enter the verification code\n we sent to your email",
              style: TextStyle(
                  fontSize: scaler.scalerT(18.0),
                  color: DayTheme.textColor,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  scaler.scalerH(40.0),
                  scaler.scalerV(140.0),
                  scaler.scalerH(40.0),
                  scaler.scalerV(65.0)),
              child: PinCodeTextField(
                appContext: context,
                keyboardType: TextInputType.number,
                length: 6,
                textStyle: textStyle(
                  fontSize: scaler.scalerT(18.0),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.done,
                cursorColor: DayTheme.primaryColor,
                pinTheme: PinTheme.defaults(
                  inactiveColor: DayTheme.textColor,
                  selectedColor: DayTheme.primaryColor,
                  activeColor: DayTheme.primaryColor,
                ),
                onChanged: (value) {
                  print(value);
                },
                onCompleted: (pin) {
                  otp.value = pin;
                },
              ),
            ),
            Text.rich(
              TextSpan(
                style: TextStyle(
                    fontSize: scaler.scalerT(14.0), color: DayTheme.textColor),
                children: [
                  TextSpan(text: "Didn't receive a code? "),
                  TextSpan(
                    text: 'Resend',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: DayTheme.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = resendOtp,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  scaler.scalerH(50.0),
                  scaler.scalerV(60.0),
                  scaler.scalerH(50.0),
                  scaler.scalerV(45.0)),
              child: Obx(() => Click(
                    text: 'VERIFY & PROCEED',
                    disabled: otp.value.length != 6,
                    onPressed: passwordVerifyOtp,
                    loading: authController.loading.value,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
