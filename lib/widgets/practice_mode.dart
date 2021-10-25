import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';

class PracticMode extends StatelessWidget {
  final String title;
  final Widget image;
  final Function onTap;

  const PracticMode({
    this.title,
    this.image,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    ScalerConfig scaler = Get.find(tag: 'scaler');

    // final boxWidth =
    //     MediaQuery.of(context).size.width - scaler.scalerH(26.0) * 2;
    // final boxHeight = boxWidth * (173.0 / 324.0);
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, scaler.scalerV(15.0), 0, 0),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black45.withOpacity(0.4), BlendMode.darken),
              child: Container(child: image),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          Text(
            title,
            style: textStyle(
                color: Color.fromRGBO(255, 255, 255, .90),
                fontSize: scaler.scalerT(20.0),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
