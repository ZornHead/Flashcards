import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/dynamic_link_handler.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/refer_card.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';

class ReferViaFriendScreen extends StatelessWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  static String id = 'refer';

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
                "assets/images/refer now.png",
              ),
            ),
            Text(
              "Refer friend via",
              style: textStyle(
                  fontSize: scaler.scalerT(14.0), color: DayTheme.textColor),
            ),
            SizedBox(
              height: scaler.scalerV(35.0),
            ),
            ReferCard(
              image: "assets/images/whatsapp.png",
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                SocialShare.shareWhatsapp(link);

                print(link);
              },
              title: "Whatsapp",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              image: "assets/images/gmail.png",
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();

                SocialShare.shareSms(link);

                print(link);
              },
              title: "Message",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              leadingIcon: Icon(Icons.pending_outlined),
              icons: Icon(Icons.arrow_forward_ios),
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                print(link);
                Share.share(link);
              },
              title: "More",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
            ReferCard(
              image: "assets/images/link.png",
              color: DayTheme.textColor,
              onpressed: () async {
                final link = await DynamicLinkHandler.createReferralLink();
                print(link);
                SocialShare.copyToClipboard(link).then(
                  (value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Referral link copied",
                      style: textStyle(fontWeight: FontWeight.w500),
                    ),
                  )),
                );
              },
              title: "Copy link",
            ),
            SizedBox(
              height: scaler.scalerV(25.0),
            ),
          ],
        ),
      ),
    );
  }
}
