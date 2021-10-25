import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';

final ScalerConfig scaler = Get.find(tag: 'scaler');

class ReferCard extends StatelessWidget {
  final String title;
  final String image;
  final Function onpressed;
  final Icon leadingIcon, icons;
  final Color color;

  const ReferCard(
      {Key key,
      this.title,
      this.image,
      this.onpressed,
      this.leadingIcon,
      this.icons,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: scaler.scalerV(10.0),
        shadowColor: DayTheme.textColor,
        margin: EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
        child: ListTile(
          trailing: IconButton(
            icon: icons ?? Icon(null),
            color: DayTheme.textColor,
            onPressed: onpressed,
          ),
          leading: leadingIcon ??
              Image(
                image: AssetImage(
                  image,
                ),
                color: color,
              ),
          title: Text(
            title,
            style: textStyle(
                fontSize: scaler.scalerT(14.0), color: DayTheme.textColor),
          ),
          onTap: onpressed,
        ),
      ),
    );
  }
}
