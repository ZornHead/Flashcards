import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ProfileOtpScreen extends HookWidget {
  static String id = 'profileotp';
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    final otp = useState("");
    showPopup() {
      popupDialog(
        context,
        text: "Your email has been \n sucessfully changed.",
        onTap: () {
          Navigator.pop(context);
        },
        popOnce: true,
      );
    }

    profileVerifyOtp() {
      authController.profileVerifyOtp(
          email: args['email'],
          name: args['name'],
          isNewsletterSubscribed: args['isNewsletterSubscribed'],
          otp: otp.value,
          profilePicture: args['profilePicture'],
          onSuccess: showPopup);
    }

    resendOtp() {
      authController.resendOtp(email: args['originalEmail']);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "OTP Verification",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: scaler.scalerV(90.0),
              ),
              Text(
                "Please enter the verification code\n we sent to your email",
                style: textStyle(
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
                  style: textStyle(
                      fontSize: scaler.scalerT(14.0),
                      color: DayTheme.textColor),
                  children: [
                    TextSpan(text: "Didn't receive a code? "),
                    TextSpan(
                      text: 'Resend',
                      style: textStyle(
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
                      onPressed: profileVerifyOtp,
                      loading: authController.loading.value,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
