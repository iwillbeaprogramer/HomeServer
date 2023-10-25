import 'package:flutter/material.dart';
import 'package:front/view/cartoon_viwer.dart';
import 'package:front/view/home_page.dart';
import 'package:front/view/login_page.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'view/cartoon_page.dart';


void main() {
  setPathUrlStrategy(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 57, 168, 151)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/":(p0) => const LoginPage(),
        "/home":(p0) => const Home(),
        "/cartoon":(p0) => const Cartoon(),
        "/cartoon/viwer":(p0) => const CartoonViewer(),
      },
    );
  }
}
