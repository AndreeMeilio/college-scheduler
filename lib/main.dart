import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Kuliah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConfig.mainColor),
        useMaterial3: true,
        fontFamily: "LibreBaskerville",
        scaffoldBackgroundColor: ColorConfig.backgroundColor
      ),
      home: LoginPage()
    );
  }
}