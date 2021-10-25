import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/screens/refer_via_friend_screen/refer_via_friend_screen.dart';
import 'package:flutter_app/screens/referred_friend_screen/referred_friend_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class ReferFriendScreen extends HookWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  static String id = 'friend';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(
          context,
          text: "Refer a friend",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: scaler.scalerH(30.0),
                    vertical: scaler.scalerV(60.0)),
                child: Image.asset(
                  "assets/images/refer_a_friend.png",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(30.0)),
                child: Text(
                  "Earn a free month of premium membership every time someone you refer signs up as a paid member. The people you invite will also receive a 10% discount as a gift from you.",
                  style: textStyle(
                      fontSize: scaler.scalerT(16.0),
                      color: DayTheme.textColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: scaler.scalerH(48.0),
                    right: scaler.scalerH(48.0),
                    bottom: scaler.scalerV(50.0),
                    top: scaler.scalerV(88.0)),
                child: Click(
                    text: 'REFER A FRIEND',
                    onPressed: () {
                      Navigator.of(context).pushNamed(ReferViaFriendScreen.id);
                    }),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ReferredFriendScreen.id);
                },
                child: Text(
                  "Referred Friends",
                  style: textStyle(
                      fontSize: scaler.scalerT(16.0),
                      color: DayTheme.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ));
  }
}
