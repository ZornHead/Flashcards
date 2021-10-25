import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final String title, numtext, denotext;
  final double percentage;
  final Function onTap;

  ProgressBar(
      {this.title,
      @required this.onTap,
      this.numtext,
      this.denotext,
      this.percentage});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      trailing: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: scaler.scalerH(03.0),
            ),
            Flexible(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(numtext,
                        overflow: TextOverflow.fade,
                        style: textStyle(
                            color: DayTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: scaler.scalerT(14.0))),
                  ),
                ),
                SizedBox(
                  width: scaler.scalerH(02.0),
                ),
                FittedBox(
                  child: Text("/",
                      overflow: TextOverflow.fade,
                      style: textStyle(
                          color: DayTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: scaler.scalerT(14.0))),
                ),
                SizedBox(
                  width: scaler.scalerH(02.0),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(denotext,
                        overflow: TextOverflow.visible,
                        style: textStyle(
                            color: DayTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: scaler.scalerT(14.0))),
                  ),
                ),
              ]),
            ),
            InkWell(
              child: Icon(
                Icons.more_vert,
                color: DayTheme.textColor,
              ),
              onTap: onTap,
            ),
          ],
        ),
      ),
      animateFromLastPercent: true,
      width: scaler.scalerH(225.0),
      animation: true,
      lineHeight: scaler.scalerV(20.0),
      percent: percentage / 100,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: DayTheme.progressBarColor,
    );
  }
}
