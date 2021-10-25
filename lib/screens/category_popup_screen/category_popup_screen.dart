import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/models/category_browse.dart';
import 'package:flutter_app/screens/browse_cards_screen/browse_cards_screen.dart';
import 'package:flutter_app/screens/card_front_screen/card_fronts_screen.dart';
import 'package:flutter_app/screens/mental_practice_screen/mental_practice_screen.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryPopupScreen extends HookWidget {
  static const String id = 'categoryPopup';

  @override
  Widget build(BuildContext context) {
    final categoryStudy = useState<dynamic>('');
    final categoriesLoading = useState<bool>(true);
    dynamic arg = ModalRoute.of(context).settings.arguments;
    print(arg['id']);
    useEffect(() {
      (() async {
        try {
          final response = await NetworkClient.get(
              '/start/category/study?type=${arg['type']}&category_id=${arg['id']}');
          print(response);

          print(response.realUri);
          dynamic categoryStudys = response.data['data'];
          categoryStudy.value = CategoryBrowse.fromJson(categoryStudys);
        } on DioError catch (e) {
          NetworkClient.errorHandler(e);
        } finally {
          categoriesLoading.value = false;
        }
      })();
      return () {};
    }, []);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: WillPopScope(
          onWillPop: () {
            Navigator.of(context).pushNamed(MentalPracticeScreen.id,
                arguments: {
                  'type': arg['type'],
                  'typeTitle': arg['typeTitle']
                });
            return Future.value(false);
          },
          child: Center(
            child: Container(
              height: scaler.scalerV(325.0),
              width: scaler.scalerH(295.0),
              child: Card(
                elevation: 30,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: scaler.scalerH(25.0),
                              top: scaler.scalerV(10.0)),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                      MentalPracticeScreen.id,
                                      arguments: {
                                        'type': arg['type'],
                                        'typeTitle': arg['typeTitle']
                                      });
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: DayTheme.textColor,
                                  size: scaler.scalerV(20.0),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: scaler.scalerV(15.0),
                        ),
                        Text(
                          arg['categoryName'],
                          textAlign: TextAlign.center,
                          style: textStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.scalerT(16),
                              color: DayTheme.textColor),
                        ),
                        SizedBox(
                          height: scaler.scalerV(25.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: scaler.scalerH(45.0)),
                          child: Column(
                            children: [
                              Click(
                                text: 'STUDY',
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(CardFronts.id, arguments: {
                                    'categoryname': arg['categoryName'],
                                    'title': categoryStudy.value.title,
                                    'image': categoryStudy.value.image,
                                    'content': categoryStudy.value.content,
                                    'video': categoryStudy.value.video,
                                    'id': categoryStudy.value.id,
                                    'type': arg['type'],
                                    'typeTitle': arg['typeTitle'],
                                    // 'progress': smartmix.progress
                                  });
                                },
                                height: scaler.scalerV(45.0),
                                color: DayTheme.progressBarColor,
                                fontSize: scaler.scalerT(12.0),
                              ),
                              SizedBox(
                                height: scaler.scalerV(15.0),
                              ),
                              Click(
                                text: 'Browse',
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      BrowseCardScreen.id,
                                      arguments: {
                                        'categoryname': arg['categoryName'],
                                        'id': arg['id'],
                                        'type': arg['type'],
                                        'typeTitle': arg['typeTitle'],
                                        //'progress': category.progress
                                      });
                                },
                                color: DayTheme.textColor,
                                height: scaler.scalerV(45.0),
                                fontSize: scaler.scalerT(12.0),
                              ),
                              SizedBox(
                                height: scaler.scalerV(15.0),
                              ),
                              Click(
                                text: 'CLOSE',
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      MentalPracticeScreen.id,
                                      arguments: {
                                        'type': arg['type'],
                                        'typeTitle': arg['typeTitle']
                                      });
                                  // Navigator.of(context).pop();
                                },
                                height: scaler.scalerV(45.0),
                                fontSize: scaler.scalerT(12.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: scaler.scalerV(30.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  // void categoryPopupScreen() {
  //   showDialog(
  //       barrierDismissible: false,
  //       useRootNavigator: false,
  //       barrierColor: Colors.white,
  //       context: context,
  //       builder: (buildContext) {
  //         return
  //             // WillPopScope(
  //             //   onWillPop: () {
  //             //     Navigator.of(context).pushNamed(MentalPracticeScreen.id,
  //             //         arguments: {'type': type, 'typeTitle': typeTitle});
  //             //     return Future.value(false);
  //             //   },
  //             //   child:
  //             AlertDialog(
  //           content: Container(
  //             width: scaler.scalerH(325.0),
  //             height: scaler.scalerV(285.0),
  //             child: Center(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(
  //                       height: scaler.scalerV(05.0),
  //                     ),
  //                     Align(
  //                         alignment: Alignment.topRight,
  //                         child: InkWell(
  //                           onTap: () {
  //                             Navigator.of(context).pushNamed(
  //                               MentalPracticeScreen.id,
  //                               // arguments: {
  //                               //   'type': type,
  //                               //   'typeTitle': typeTitle
  //                               // }
  //                             );
  //                           },
  //                           child: Icon(
  //                             Icons.clear,
  //                             color: DayTheme.textColor,
  //                             size: scaler.scalerV(20.0),
  //                           ),
  //                         )),
  //                     SizedBox(
  //                       height: scaler.scalerV(25.0),
  //                     ),
  //                     Text(
  //                       "categoryname",
  //                       // categoryname,
  //                       textAlign: TextAlign.center,
  //                       style: textStyle(
  //                           fontWeight: FontWeight.w600,
  //                           fontSize: scaler.scalerT(16),
  //                           color: DayTheme.textColor),
  //                     ),
  //                     SizedBox(
  //                       height: scaler.scalerV(15.0),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(
  //                           horizontal: scaler.scalerH(30.0)),
  //                       child: Column(
  //                         children: [
  //                           Click(
  //                             text: 'STUDY',
  //                             onPressed: () {
  //                               // smartmix.progress != '100'
  //                               //     ?
  //                               Navigator.of(context).pushNamed(
  //                                 CardFronts.id,
  //                                 //   arguments: {
  //                                 //   'categoryname': categoryname,
  //                                 //   'title': categoryBrowse.title,
  //                                 //   'image': categoryBrowse.image,
  //                                 //   'content': categoryBrowse.content,
  //                                 //   'video': categoryBrowse.video,
  //                                 //   'id': categoryBrowse.id,
  //                                 //   'type': type,
  //                                 //   'typeTitle': typeTitle,
  //                                 //   'progress': smartmix.progress
  //                                 // }
  //                               );
  //                               // : SnackbarHandler.normalToast(
  //                               //     "All Cards Used", '');
  //                             },
  //                             height: scaler.scalerV(45.0),
  //                             color: DayTheme.progressBarColor,
  //                             fontSize: scaler.scalerT(12.0),
  //                           ),
  //                           SizedBox(
  //                             height: scaler.scalerV(15.0),
  //                           ),
  //                           Click(
  //                             text: 'Browse',
  //                             onPressed: () {
  //                               Navigator.of(context).pushNamed(
  //                                 BrowseCardScreen.id,

  //                                 // arguments: {
  //                                 //   'categoryname': categoryname,
  //                                 //   'id': category.id,
  //                                 //   'type': type,
  //                                 //   'typeTitle': typeTitle,
  //                                 //   'progress': category.progress
  //                                 // }
  //                               );
  //                             },
  //                             color: DayTheme.textColor,
  //                             height: scaler.scalerV(45.0),
  //                             fontSize: scaler.scalerT(12.0),
  //                           ),
  //                           SizedBox(
  //                             height: scaler.scalerV(15.0),
  //                           ),
  //                           Click(
  //                             text: 'CLOSE',
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                               // Navigator.of(context).pushNamed(
  //                               //   MentalPracticeScreen.id,
  //                               // arguments: {
  //                               //   'type': type,
  //                               //   'typeTitle': typeTitle
  //                               // }
  //                               //);
  //                             },
  //                             height: scaler.scalerV(45.0),
  //                             fontSize: scaler.scalerT(12.0),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: scaler.scalerV(30.0),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           // ),
  //         );
  //       });
  // }
}
