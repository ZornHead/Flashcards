import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/models/referal.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}

class ReferredFriendScreen extends HookWidget {
  static const String id = 'referred';
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    final friendList = useState<List<dynamic>>([]);

    final friendLoading = useState<bool>(true);

    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
            '/RefferedList',
          );
          List<dynamic> refferedList = response.data['data'];
          friendList.value = refferedList.map((referal) {
            return Referal.fromJson(referal);
          }).toList();
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          friendLoading.value = false;
        }
      })();
      return () {};
    }, []);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(context, text: "Referred Friends"),
        body: (friendLoading.value)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (friendList.value.length != 0)
                ? ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(
                        0, scaler.scalerV(20.0), 0, scaler.scalerV(20.0)),
                    itemCount: friendList.value.length,
                    itemBuilder: (context, int index) {
                      var myDate =
                          DateTime.tryParse(friendList.value[index].createdAt);
                      print(friendList.value.length);
                      return Container(
                        child: ListTile(
                          leading: Container(
                            height: scaler.scalerH(42.0),
                            width: scaler.scalerH(42.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(scaler.scalerH(70.0)),
                              border: Border.all(
                                  width: scaler.scalerH(0.2),
                                  color: DayTheme.textColor),
                              image: DecorationImage(
                                image: friendList.value[index].getImageUrls() !=
                                        null
                                    ? NetworkImage(
                                        friendList.value[index].getImageUrls())
                                    : AssetImage("assets/images/Users.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          trailing: Text(
                            myDate.isToday()
                                ? "Today"
                                : myDate.isYesterday()
                                    ? "Yesterday"
                                    : DateFormat("dd-MM-yyyy").format(myDate),
                            style: textStyle(
                                fontSize: scaler.scalerT(12),
                                color: DayTheme.textColor,
                                fontWeight: FontWeight.w500),
                          ),
                          title: Text(
                            friendList.value[index].name,
                            style: textStyle(
                                fontSize: scaler.scalerT(15),
                                color: DayTheme.textColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      "No Referred Friends",
                      style: textStyle(
                          color: DayTheme.textColor,
                          fontSize: scaler.scalerT(15.0)),
                    ),
                  ));
  }
}
