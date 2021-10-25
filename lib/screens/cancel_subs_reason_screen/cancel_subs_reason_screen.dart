import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:get/get.dart';

class CancelSubsReasonScreen extends StatefulWidget {
  static const String id = 'subcancel';

  @override
  State<CancelSubsReasonScreen> createState() => _CancelSubsReasonScreenState();
}

class _CancelSubsReasonScreenState extends State<CancelSubsReasonScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  String reasonList;
  final formKey = GlobalKey<FormState>();
  final FocusNode feedbackNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    cancel() {
      if (formKey.currentState.validate()) {
        Navigator.of(context).pushNamed(ProfileScreen.id);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Cancel Subscription",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0), scaler.scalerV(30.0),
            scaler.scalerH(25.0), 0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                style: textStyle(fontSize: scaler.scalerT(15.0)),
                decoration: InputDecoration(
                  labelText: 'Reason for cancellation',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: DayTheme.primaryColor,
                    ),
                  ),
                  labelStyle: textStyle(
                      fontSize: scaler.scalerT(14.0),
                      fontWeight: FontWeight.w500),
                ),
                value: reasonList,
                onChanged: (value) {
                  setState(() {
                    reasonList = value;
                  });
                },
                items: ['High Cost', 'A', 'B', 'C']
                    .map((label) => DropdownMenuItem(
                        child: Text(
                          label,
                          style: textStyle(
                              fontSize: scaler.scalerT(16.0),
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        value: label))
                    .toList(),
                validator: (item) {
                  if (item == null)
                    return "Reason is required";
                  else
                    return null;
                },
              ),
              SizedBox(
                height: scaler.scalerV(30.0),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  feedbackNode.unfocus();
                  cancel();
                },
                style: textStyle(
                    fontSize: scaler.scalerT(15.0),
                    fontWeight: FontWeight.w600),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: null,
                decoration: InputDecoration(
                  labelStyle: textStyle(
                      fontSize: scaler.scalerT(14.0),
                      fontWeight: FontWeight.w500),
                  labelText: "Your feedback",
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
                validator: (value) => Helpers.validateEmpty(
                  value,
                  "feedback",
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    scaler.scalerH(25.0),
                    scaler.scalerV(270.0),
                    scaler.scalerH(25.0),
                    scaler.scalerV(10.0)),
                child: Click(
                  text: "Submit & Cancel",
                  onPressed: cancel,
                  color: Colors.white,
                  borderSide: BorderSide(
                      width: scaler.scalerV(0.4), color: DayTheme.textColor),
                  textcolor: DayTheme.textColor,
                ),
              ),
              Text(
                "You will be redirected to app\n store for manual cancellation",
                style: textStyle(
                    fontSize: scaler.scalerT(14), color: DayTheme.textColor),
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
