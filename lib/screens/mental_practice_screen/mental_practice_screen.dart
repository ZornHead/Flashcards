import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/category_browse.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/screens/category_popup_screen/category_popup_screen.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/screens/smartmix_popup_screen/smartmix_popup_screen.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/progress_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class MentalPracticeScreen extends HookWidget {
  static const String id = 'mental';

  final ScalerConfig scaler = Get.find(tag: 'scaler');

  @override
  Widget build(BuildContext context) {
    dynamic arg = ModalRoute.of(context).settings.arguments;
    final categoryList = useState<List<Category>>([]);
    final startsmartmix = useState<dynamic>('');
    final smartmixList = useState<dynamic>('');
    final categoriesLoading = useState<bool>(true);

    useEffect(() {
      (() async {
        try {
          final response =
              await NetworkClient.get('/course?type=${arg['type']}');

          List<dynamic> _categoryList = response.data['data']['categories'];
          categoryList.value =
              _categoryList.map((json) => Category.fromJson(json)).toList();
          dynamic smartmixLists = response.data['data']['smart_mix_global'];
          smartmixList.value = Category.fromJson(smartmixLists);
          if (response.statusCode == 200) {
            SnackbarHandler.normalToast(
                'Progress % = ${response.data['data']['smart_mix_global']['progress']}',
                'Due Cards= ${response.data['data']['smart_mix_global']['cards_due']}');
          }
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        }
        try {
          final response =
              await NetworkClient.get('/smart-mix?type=${arg['type']}');
          dynamic startsmartmixs = response.data['data'];
          startsmartmix.value = CategoryBrowse.fromJson(startsmartmixs);
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          categoriesLoading.value = false;
        }
      })();
      return () {};
    }, []);
    return Scaffold(
        appBar: header(context, text: arg['typeTitle'], onTap: () {
          Navigator.pushNamed(context, HomeScreen.id);
        }),
        body: WillPopScope(
            onWillPop: () {
              Navigator.pushNamed(context, HomeScreen.id);
              return Future.value(false);
            },
            child: categoriesLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          Card(
                            color: DayTheme.pinkColor,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  scaler.scalerH(22.0),
                                  scaler.scalerV(10.0),
                                  scaler.scalerH(22.0),
                                  0),
                              child: Column(
                                children: [
                                  Click(
                                    text: "START SMART MIX",
                                    onPressed: () {
                                      smartmixList.value.progress != '100'
                                          ? Navigator.of(context).pushNamed(
                                              CardFronts.id,
                                              arguments: {
                                                'id': startsmartmix.value.id,
                                                'title':
                                                    startsmartmix.value.title,
                                                'image':
                                                    startsmartmix.value.image,
                                                'content':
                                                    startsmartmix.value.content,
                                                'video':
                                                    startsmartmix.value.video,
                                                'typeTitle': arg['typeTitle'],
                                                'type': arg['type'],
                                                "Smart Mix": "Smart Mix"
                                              },
                                            )
                                          : SnackbarHandler.errorToast(
                                              " No card Schedule",
                                              'Please Visit Later');

                                      // popupDialogButton(context,
                                      //     text:
                                      //         "You are not a premium \nmember. Subscribe or Refer a friend to get\n 1 month Free subscription.",
                                      //     btext: "BUY SUBSCRIPTION",
                                      //     onPressed: () {
                                      //       Navigator.of(context)
                                      //           .pushNamed(SubscriotionScreen.id);
                                      //     },
                                      //     h: scaler.scalerV(10.0),
                                      //     brtext: "REFER A FRIEND",
                                      //     onTap: () {
                                      //       Navigator.of(context)
                                      //           .pushNamed(ReferViaFriendScreen.id);
                                      //     }
                                      //     );
                                    },
                                    height: scaler.scalerV(45.0),
                                  ),
                                  SizedBox(
                                    height: scaler.scalerV(10.0),
                                  ),
                                  ProgressBar(
                                    percentage: double.tryParse(
                                        smartmixList.value.progress),
                                    title: "",
                                    onTap: () {
                                      smartmixPopupScreen(
                                        context,
                                        "Smart Mix",
                                        startsmartmix.value,
                                        arg['type'],
                                        arg['typeTitle'],
                                        smartmixList.value,
                                      );
                                    },
                                    numtext:
                                        smartmixList.value.openCards.toString(),
                                    denotext: smartmixList.value.totalCards
                                        .toString(),
                                  ),
                                  SizedBox(
                                    height: scaler.scalerV(13.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            scaler.scalerH(25.0),
                            scaler.scalerV(100.0),
                            scaler.scalerH(25.0),
                            scaler.scalerV(20.0)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryList.value.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: scaler.scalerV(15.0),
                                  ),
                                  Text(
                                    categoryList.value[index].categoryName,
                                    style: textStyle(
                                        color: DayTheme.textColor,
                                        fontSize: scaler.scalerT(16.0)),
                                  ),
                                  SizedBox(
                                    height: scaler.scalerV(05.0),
                                  ),
                                  ProgressBar(
                                    percentage: double.tryParse(
                                      categoryList.value[index].progress,
                                    ),
                                    onTap: () {
                                      categoryList.value[index].progress !=
                                              '100'
                                          ? Navigator.of(context).pushNamed(
                                              CategoryPopupScreen.id,
                                              arguments: {
                                                  'id': categoryList
                                                      .value[index].id,
                                                  'categoryName': categoryList
                                                      .value[index]
                                                      .categoryName,
                                                  'type': arg['type'],
                                                  'typeTitle': arg['typeTitle'],
                                                })
                                          : SnackbarHandler.errorToast(
                                              "No card Schedule",
                                              'Please Visit Later');
                                    },
                                    numtext: categoryList.value[index].openCards
                                        .toString(),
                                    denotext: categoryList
                                        .value[index].totalCards
                                        .toString(),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )));
  }
}
