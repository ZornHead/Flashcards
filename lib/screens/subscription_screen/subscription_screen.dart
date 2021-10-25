import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulHookWidget {
  static const String id = 'subscription';

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final ScalerConfig scaler = Get.find(tag: 'scaler');
  final AuthController authController = Get.find(tag: 'auth_controller');
  final List<String> subscriptionLists = [
    'com.mma.flash.tempmonthly',
    'com.mma.flash.tempyearly'
  ];

  Widget build(BuildContext context) {
    final group = useState<IAPItem>(null);
    final loading = useState(false);
    final subscriptions = useState<List<IAPItem>>([]);

    renderItem() {
      return Column(
        children: subscriptions.value
            .map(
              (item) => Column(
                children: [
                  SizedBox(
                    height: scaler.scalerV(53.0),
                    child: Card(
                      elevation: 15,
                      shadowColor: Color(0xFFFFD5D5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                scaler.scalerH(15.0), 0, 0, 0),
                            child: Text(item.description,
                                style: textStyle(
                                    fontSize: scaler.scalerT(14.0),
                                    color: DayTheme.textColor)),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(scaler.scalerH(27.0),
                                0, scaler.scalerH(60.0), 0),
                            child: Text(item.localizedPrice,
                                style: textStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: scaler.scalerT(16.0),
                                    color: DayTheme.primaryColor)),
                          ),
                          Radio(
                              activeColor: DayTheme.primaryColor,
                              value: group.value?.productId == item.productId
                                  ? 1
                                  : 0,
                              groupValue: 1,
                              onChanged: (_value) {
                                group.value = item;
                              }),
                          SizedBox(
                            height: scaler.scalerV(30.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scaler.scalerV(20.0),
                  ),
                ],
              ),
            )
            .toList(),
      );
    }

    restorePurchase() async {
      try {
        var purchaseHistory =
            await FlutterInappPurchase.instance.getPurchaseHistory();
        var lastPurchase = purchaseHistory[0];
        if (lastPurchase != null) {
          authController.confirmSubscription(
              lastPurchase.productId,
              Platform.isAndroid
                  ? lastPurchase.purchaseToken
                  : lastPurchase.transactionReceipt, () {
            popupDialog(context, text: "Payment Successful", onTap: () {
              Navigator.of(context).pop();
            });
          });
        }
      } catch (e) {
      } finally {}
    }

    useEffect(() {
      void initIAP() async {
        try {
          await FlutterInappPurchase.instance.initConnection;
        } catch (e) {
          print(e);
        }
      }

      initIAP();

      StreamSubscription connectionUpdatedSubscription =
          FlutterInappPurchase.connectionUpdated.listen((connected) async {
        loading.value = true;
        print('connection-updated: $connected');
        try {
          subscriptions.value = await FlutterInappPurchase.instance
              .getSubscriptions(subscriptionLists);
          group.value = subscriptions.value[0];
        } catch (e) {
          print(e);
        } finally {
          loading.value = false;
        }
      }, onError: (e) {
        print(e);
      });

      StreamSubscription purchaseUpdatedSubscription =
          FlutterInappPurchase.purchaseUpdated.listen((productItem) {
        authController.confirmSubscription(
            productItem.productId,
            Platform.isAndroid
                ? productItem.purchaseToken
                : productItem.transactionReceipt, () {
          popupDialog(context, text: "Payment Successful", onTap: () {
            Navigator.of(context).pop();
          });
        });
        print('purchase-updated: $productItem');
      });

      StreamSubscription purchaseErrorSubscription =
          FlutterInappPurchase.purchaseError.listen((purchaseError) {
        print('purchase-error: $purchaseError');
      });

      return () {
        connectionUpdatedSubscription.cancel();
        connectionUpdatedSubscription = null;
        purchaseUpdatedSubscription.cancel();
        purchaseUpdatedSubscription = null;
        purchaseErrorSubscription.cancel();
        purchaseErrorSubscription = null;
        FlutterInappPurchase.instance.endConnection;
      };
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(context, text: "Subscription"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: scaler.scalerH(25.0)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: scaler.scalerV(30.0),
              ),
              renderItem() ?? SizedBox(),
              SizedBox(
                height: scaler.scalerV(40.0),
              ),
              Text(
                "With a monthly or yearly subscription, you can have uninterrupted premium access to all app features so that you can practice MMA. Remember, you can cancel your subscription any time and use of our free complimentary premium access when someone you refer sign up.",
                style: textStyle(
                    height: scaler.scalerV(1.5),
                    fontSize: scaler.scalerT(17.0),
                    color: DayTheme.textColor),
              ),
              SizedBox(
                height: scaler.scalerV(50.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
                child: Click(
                    text: 'PROCEED',
                    disabled: group.value == null,
                    onPressed: () {
                      FlutterInappPurchase.instance
                          .requestSubscription(group.value.productId);
                    }),
              ),
              SizedBox(
                height: scaler.scalerV(25.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scaler.scalerH(20.0)),
                child: Click(
                  text: 'RESTORE SUBSCRIPTION',
                  disabled: group.value == null,
                  onPressed: restorePurchase,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
