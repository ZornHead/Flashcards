import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/controllers/contact_controller.dart';
import 'package:flutter_app/widgets/app_router.dart';
import 'package:flutter_app/widgets/auth_router.dart';
import 'package:flutter_app/widgets/init_router.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  Get.put(AuthController(), tag: 'auth_controller');
  Get.put(ContactController(), tag: 'contact_controller');
  final AuthController authController = Get.find(tag: 'auth_controller');
  await GetStorage.init();
  authController.init();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthController authController = Get.find(tag: 'auth_controller');

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
        home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(body: Center(child: Text("Error")));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => authController.loggedIn.value
                      ? AppRouter()
                      : authController.onboarding.value
                          ? AuthRouter()
                          : InitRouter(),
                );
              }

              return Scaffold(
                body: Center(
                  child: Scaffold(body: Center(child: Text("Loading..."))),
                ),
              );
            }));
  }
}
