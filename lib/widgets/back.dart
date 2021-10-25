// import 'package:flutter/material.dart';
// import 'package:flutter_app/utils/scaler_config.dart';
// import 'package:get/get.dart';

// class Back extends StatelessWidget {
//   final Function onTap;

//   const Back({Key key, this.onTap}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     ScalerConfig scaler = Get.find(tag: 'scaler');

//     return Column(
//       children: [
//         SizedBox(height: scaler.scalerV(20.0)),
//         Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                   scaler.scalerH(10.0), 0, scaler.scalerH(10.0), 0),
//               child: IconButton(
//                 onPressed: onTap ??
//                     () {
//                       Navigator.of(context).pop();
//                     },
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
