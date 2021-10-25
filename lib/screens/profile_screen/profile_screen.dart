import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/change_password_screen/change_password_screen.dart';
import 'package:flutter_app/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter_app/screens/subscription_screen/subscription_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ProfileScreen extends HookWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');
  static const String id = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        text: "Profile",
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EditProfileScreen.id);
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(scaler.scalerH(40.0),
                      scaler.scalerV(30.0), scaler.scalerH(20.0), 0),
                  child: Image.asset(
                    "assets/images/editicon.png",
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                margin: EdgeInsets.fromLTRB(
                    scaler.scalerH(0), 0, 0, scaler.scalerV(20)),
                height: scaler.scalerH(140.0),
                width: scaler.scalerH(140.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scaler.scalerH(70.0)),
                  border: Border.all(
                      width: scaler.scalerH(4.5), color: Color(0xFFFFD5D5)),
                  image: DecorationImage(
                    image: authController.user.value.getImageUrl() != null
                        ? NetworkImage(authController.user.value.getImageUrl())
                        : AssetImage("assets/images/Users.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            Obx(
              () => Text(
                authController.user.value.name,
                style: textStyle(
                    fontSize: scaler.scalerT(18.0),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Obx(
              () => Text(
                authController.user.value.email,
                style: textStyle(
                    fontSize: scaler.scalerT(14.0), color: DayTheme.textColor),
              ),
            ),
            SizedBox(
              height: scaler.scalerV(30.0),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                  elevation: 15,
                  shadowColor: Color(0xFFFFD5D5),
                  margin:
                      EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, scaler.scalerV(20.0), 0, 0),
                        child: Text(
                          'Subscription',
                          style: textStyle(
                              fontSize: scaler.scalerT(16.0),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              0, scaler.scalerV(20.0), 0, scaler.scalerV(10.0)),
                          child: Text('You are a',
                              style: textStyle(
                                  fontSize: scaler.scalerT(14.0),
                                  color: DayTheme.textColor))),
                      DottedBorder(
                        dashPattern: [8, 4],
                        strokeWidth: scaler.scalerH(2.0),
                        color: Color(0xFFFFD5D5),
                        child: Container(
                          height: scaler.scalerV(42.0),
                          width: scaler.scalerH(185.0),
                          child: Obx(
                            () => Center(
                                child: Text(
                              authController.premium.value
                                  ? "PREMIUM MEMBER"
                                  : "FREE MEMBER",
                              style: textStyle(
                                  fontSize: scaler.scalerT(18.0),
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: scaler.scalerV(30.0),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, scaler.scalerV(45.0), 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ChangePasswordScreen.id);
                },
                child: Text(
                  "Change password",
                  style: textStyle(
                      color: DayTheme.primaryColor,
                      fontSize: scaler.scalerT(16.0),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Obx(() => authController.premium.value
                ? Container()
                : Padding(
                    padding: EdgeInsets.fromLTRB(
                      scaler.scalerH(50.0),
                      scaler.scalerV(45.0),
                      scaler.scalerH(50.0),
                      scaler.scalerV(30.0),
                    ),
                    child: Click(
                        text: 'SUBSCRIBE NOW',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SubscriptionScreen.id);
                        }),
                  )),
            Obx(
              () => authController.user.value.isSubscribed
                  ? Container()
                  : Text(
                      "Canceling at any time is easy",
                      style: textStyle(
                          fontSize: scaler.scalerT(16.0),
                          color: DayTheme.textColor),
                    ),
            ),
            SizedBox(
              height: scaler.scalerV(40.0),
            )
          ],
        ),
      ),
    );
  }
}
