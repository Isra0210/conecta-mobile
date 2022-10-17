import 'package:conectamaispg/pages/home/home_page.dart';
import 'package:conectamaispg/pages/login/login_page.dart';
import 'package:conectamaispg/pages/research/research_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/home/home_binding.dart';
import 'bindings/login/login_binding.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void handleUser(Stream<User?> stream) {
    stream.listen(
      (user) async {
        if (user == null) {
          Get.offAllNamed(LoginPage.route);
        } else {
          if (Get.rawRoute!.settings.name != HomePage.route) {
            Get.offAllNamed(HomePage.route);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: LoginBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Conecta Mais PG',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: LoginPage.route,
      onInit: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      },
      onReady: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      },
      getPages: [
        GetPage(
          name: LoginPage.route,
          page: () => const LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: ResearchDetailsPage.route,
          page: () => const ResearchDetailsPage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: HomePage.route,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
