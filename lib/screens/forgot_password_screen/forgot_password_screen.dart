import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/password_otp_screen/password_otp_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends HookWidget {
  static const String id = 'forget';
  final formKey = GlobalKey<FormState>();
  final FocusNode emailNode = FocusNode();

  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');

  @override
  Widget build(BuildContext context) {
    final email = useState("");

    forgotPassword() {
      if (formKey.currentState.validate()) {
        authController.forgotPassword(
          email: email.value,
          onSuccess: () {
            Navigator.of(context).pushReplacementNamed(PasswordOtpScreen.id,
                arguments: {"email": email.value});
          },
        );
      }
    }

    return Scaffold(
      appBar: authheader(context, text: ""),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              SizedBox(height: scaler.scalerV(100.0)),
              Text('Forgot Password',
                  style: textStyle(
                      color: DayTheme.primaryColor,
                      fontSize: scaler.scalerT(26.0),
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: scaler.scalerV(30.0),
              ),
              Text(
                "Please enter the verification code \n we sent to your email",
                style: textStyle(
                    fontSize: scaler.scalerT(18.0),
                    color: DayTheme.textColor,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0),
                    scaler.scalerV(90.0), scaler.scalerH(25.0), 0),
                child: Column(
                  children: [
                    Input(
                      obscureText: false,
                      labelText: 'Enter email',
                      keyboardtype: TextInputType.emailAddress,
                      initialValue: email.value,
                      onChanged: (String text) {
                        email.value = text;
                      },
                      validator: Helpers.validateEmail,
                      onEditingComplete: () {
                        emailNode.unfocus();
                        forgotPassword();
                      },
                      focusNode: emailNode,
                    ),
                    SizedBox(height: scaler.scalerV(80.0)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          scaler.scalerH(25), 0, scaler.scalerH(25), 0),
                      child: Obx(
                        () => Click(
                            loading: authController.loading.value,
                            text: 'SEND',
                            onPressed: forgotPassword),
                      ),
                    ),
                    SizedBox(height: scaler.scalerV(40.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
