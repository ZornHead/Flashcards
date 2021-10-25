import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/controllers/contact_controller.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContactScreen extends HookWidget {
  static const String id = 'contact';
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final ContactController contactController =
      Get.find(tag: 'contact_controller');
  final AuthController authController = Get.find(tag: 'auth_controller');
  final formKey = GlobalKey<FormState>();
  final FocusNode subjectNode = FocusNode();
  final FocusNode messageNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final subject = useState("");
    final message = useState("");
    showPopup() {
      popupDialog(
        context,
        text: "Message Sent Successfully",
        onTap: () {
          Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.id));
        },
        popOnce: true,
      );
    }

    submit() {
      if (formKey.currentState.validate()) {
        formKey.currentState.reset();

        contactController.contactUs(
            name: authController.user().name,
            subject: subject.value,
            message: message.value,
            onSuccess: showPopup);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Contact",
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(scaler.scalerH(20.0),
              scaler.scalerV(50.0), scaler.scalerH(20.0), 0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                Input(
                  labelText: 'Subject',
                  initialValue: subject.value,
                  onChanged: (String text) {
                    subject.value = text;
                  },
                  validator: (value) => Helpers.validateEmpty(
                    value,
                    "Subject",
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    subjectNode.unfocus();
                    messageNode.requestFocus();
                  },
                  focusNode: subjectNode,
                ),
                SizedBox(
                  height: scaler.scalerV(30.0),
                ),
                TextFormField(
                  style: textStyle(
                      fontSize: scaler.scalerT(15.0),
                      fontWeight: FontWeight.w600),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelStyle: textStyle(
                        fontSize: scaler.scalerT(14.0),
                        fontWeight: FontWeight.w500),
                    labelText: "Your message",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: DayTheme.primaryColor,
                      ),
                    ),
                    hoverColor: DayTheme.primaryColor,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: DayTheme.textColor,
                      ),
                    ),
                  ),
                  focusNode: messageNode,
                  initialValue: message.value,
                  onChanged: (value) => message.value = value,
                  validator: (value) => Helpers.validateEmpty(
                    value,
                    "Message",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0),
                      scaler.scalerV(50.0), scaler.scalerH(25.0), 0),
                  child: Obx(
                    () => Click(
                      text: "SUBMIT",
                      onPressed: submit,
                      loading: contactController.loading.value,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
