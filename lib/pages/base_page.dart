import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/pages/dashboard_page.dart';
import 'package:college_scheduler/pages/input_data_page.dart';
import 'package:college_scheduler/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin{

  late TabController _menuController;
  late BaseMenuCubit _cubit;
  late CreateAndUpdateEventCubit _createAndUpdateCubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<BaseMenuCubit>(context, listen:false);
    _createAndUpdateCubit = BlocProvider.of<CreateAndUpdateEventCubit>(context, listen: false);
    _menuController = TabController(
      length: 3,
      vsync: this
    );
    
    _menuController.index = 0;

    WidgetsBinding.instance.addPostFrameCallback((_){
      _menuController.addListener((){
        _cubit.changeIndexActiveMenu(_menuController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BaseMenuCubit, int>(
          builder: (context, state) {
            _menuController.index = state;
            return Column(
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
                            "Events",
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
            );
          }
        ),
      ),
    );
  }
}