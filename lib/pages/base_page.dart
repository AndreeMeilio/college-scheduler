import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/pages/dashboard_page.dart';
import 'package:college_scheduler/pages/input_data_page.dart';
import 'package:college_scheduler/pages/settings_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin{

  late TabController _menuController;

  @override
  void initState() {
    super.initState();

    _menuController = TabController(
      length: 3,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.0,
          children: [
            Expanded(
              child: TabBarView(
                controller: _menuController,
                children: [
                  DashboardPage(),
                  InputDataPage(),
                  SettingsPage()
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorConfig.mainColor,
                    spreadRadius: 1,
                    blurRadius: 6.0,
                    offset: Offset(-2, 0)
                  )
                ]
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TabBar(
                controller: _menuController,
                dividerColor: Colors.transparent,
                labelColor: ColorConfig.mainColor,
                indicatorColor: ColorConfig.mainColor,
                tabs: [
                  Column(
                    spacing: 4.0,
                    children: [
                      Icon(Icons.home),
                      Text(
                        "Home",
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                  Column(
                    spacing: 4.0,
                    children: [
                      Icon(Icons.add_circle_outline_rounded),
                      Text(
                        "Input Data",
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                  Column(
                    spacing: 4.0,
                    children: [
                      Icon(Icons.settings),
                      Text(
                        "Settings",
                        style: TextStyleConfig.body1,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}