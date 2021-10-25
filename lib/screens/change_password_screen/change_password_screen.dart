import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends HookWidget {
  static const String id = 'change';

  final AuthController authController = Get.find(tag: 'auth_controller');
  final FocusNode confirmPasswordNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    final recentPassword = useState("");
    final newPassword = useState("");
    final confirmPassword = useState("");

    showPopup() {
      popupDialog(
        context,
        text: "Your password has been \n sucessfully changed.",
        onTap: () {
          Navigator.pop(context);
        },
        popOnce: true,
      );
    }

    update() {
      if (formKey.currentState.validate()) {
        authController.changePassword(
          recentPassword: recentPassword.value,
          newPassword: newPassword.value,
          onSuccess: showPopup,
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Change Password",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              SizedBox(
                height: scaler.scalerV(70.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    scaler.scalerH(25.0), 0, scaler.scalerH(25.0), 0),
                child: Column(
                  children: [
                    Input(
                        obscureText: true,
                        labelText: 'Current password',
                        initialValue: recentPassword.value,
                        validator: (value) =>
                            Helpers.validateEmpty(value, 'Current Password'),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          passwordNode.unfocus();
                          newPasswordNode.requestFocus();
                        },
                        onChanged: (String text) {
                          recentPassword.value = text;
                        },
                        focusNode: passwordNode),
                    SizedBox(height: scaler.scalerV(20.0)),
                    Input(
                        obscureText: true,
                        labelText: 'Enter new password',
                        validator: (value) => Helpers.validateCurrentPassword(
                            value, recentPassword.value),
                        textInputAction: TextInputAction.next,
                        initialValue: newPassword.value,
                        onChanged: (String text) {
                          newPassword.value = text;
                        },
                        onEditingComplete: () {
                          newPasswordNode.unfocus();
                          confirmPasswordNode.requestFocus();
                        },
                        focusNode: newPasswordNode),
                    SizedBox(height: scaler.scalerV(20.0)),
                    Input(
                        obscureText: true,
                        labelText: 'Confirm new password',
                        initialValue: newPassword.value,
                        onChanged: (String text) {
                          confirmPassword.value = text;
                        },
                        validator: (value) => Helpers.validateConfirmPassword(
                              value,
                              newPassword.value,
                            ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          confirmPasswordNode.unfocus();
                          update();
                        },
                        focusNode: confirmPasswordNode),
                    SizedBox(height: scaler.scalerV(80.0)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          scaler.scalerH(25.0), 0, scaler.scalerH(25.0), 0),
                      child: Obx(
                        () => Click(
                          text: 'UPDATE',
                          onPressed: update,
                          loading: authController.loading.value,
                          disabled: authController.loading.value,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scaler.scalerV(40.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
