import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/contact_screen/contact_screen.dart';
import 'package:flutter_app/screens/privacy_screen/privacy_screen.dart';
import 'package:flutter_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter_app/screens/refer_friend_screen/refer_friend_screen.dart';
import 'package:flutter_app/screens/terms_services_screen/terms_services_screen.dart';
import 'package:flutter_app/screens/training_tip_screen/training_tip_screen.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info/package_info.dart';

class Drawers extends StatelessWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');
  final InAppReview _inAppReview = InAppReview.instance;

  final String _appStoreId = '1571624494';
  final String _microsoftStoreId = '';

  _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: scaler.scalerV(25.0),
            width: scaler.scalerH(49.0),
            margin: EdgeInsets.fromLTRB(scaler.scalerH(41.0), 0,
                scaler.scalerH(20.0), scaler.scalerV(30.0)),
            decoration: BoxDecoration(
              color: DayTheme.primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: Center(
                child: FutureBuilder(
              future: getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                'v ${snapshot.hasData ? snapshot.data : "Loading ...."}',
                style:
                    textStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )),
          ),
        ),
        Container(
          height: scaler.scalerV(390.0),
          child: Image(
            image: AssetImage("assets/images/sidecurve.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(scaler.scalerH(25.0), 0, 0, 0),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      Navigator.of(context).pop();

                      Navigator.of(context).pushNamed(ProfileScreen.id);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(scaler.scalerH(13.0),
                          scaler.scalerV(70.0), 0, scaler.scalerV(20.0)),
                      height: scaler.scalerH(73.0),
                      width: scaler.scalerH(73.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: scaler.scalerH(0.2),
                            color: DayTheme.textColor),
                        borderRadius:
                            BorderRadius.circular(scaler.scalerH(73.0) / 2),
                        image: DecorationImage(
                          image: authController.user().getImageUrl() != null
                              ? NetworkImage(
                                  authController.user().getImageUrl())
                              : AssetImage("assets/images/Users.jpeg"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      scaler.scalerH(13.0), 0, 0, scaler.scalerV(70.0)),
                  child: Obx(
                    () => Text(
                      authController.user().name,
                      style: textStyle(
                          fontSize: scaler.scalerT(20.0),
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text('Profile',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.of(context).pushNamed(ProfileScreen.id);
              },
            ),
            ListTile(
              title: Text('Contact us',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ContactScreen.id);
              },
            ),
            ListTile(
              title: Text('Rate this app',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();
                _openStoreListing();
              },
            ),
            ListTile(
              title: Text('Earn rewards',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.of(context).pushNamed(ReferFriendScreen.id);
              },
            ),
            ListTile(
              title: Text('Training tips',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(TrainingTipScreen.id);
              },
            ),
            ListTile(
              title: Text('Privacy policy',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(PrivacyScreen.id);
              },
            ),
            ListTile(
              title: Text('Terms of services',
                  style: textStyle(
                      color: DayTheme.textColor,
                      fontSize: scaler.scalerT(20.0))),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(TermsServiesScreen.id);
              },
            ),
            ListTile(
              title: Text(
                'Signout',
                style: textStyle(
                    color: DayTheme.textColor, fontSize: scaler.scalerT(20.0)),
              ),
              onTap: () {
                showAlertDialog(context,
                    title: "Signout", text: "Are you sure you want to signout?",
                    onPressedYes: () {
                  authController.logout();
                });
              },
            ),
          ],
        ),
      ]),
    );
  }
}
