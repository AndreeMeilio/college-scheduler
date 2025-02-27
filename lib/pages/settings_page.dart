import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuoteWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Settings",
                style: TextStyleConfig.heading1,
              ),
            ),
            SettingsListWidget(),
          ],
        ),
      ),
    );
  }
}

class SettingsListWidget extends StatefulWidget {
  const SettingsListWidget({super.key});

  @override
  State<SettingsListWidget> createState() => _SettingsListWidgetState();
}

class _SettingsListWidgetState extends State<SettingsListWidget> {

  late List<Map<String, dynamic>> _dataMenu;

  @override
  void initState() {
    super.initState();

    _dataMenu = List.from([
      {
        "label" : "Data",
        "item": List.from(<String>[
          "History Event",
          "Data Class",
          "Data Dosen",
          "Files"
        ])
      },
      {
        "label" : "Notification",
        "item": List.from(<String>[
          "Reminder Event",
          "Reminder Input"
        ])
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        return SettingsDataSectionWidget(
          label: _dataMenu[index]["label"],
          dataMenu: _dataMenu[index]["item"],
        );
      }, 
      separatorBuilder: (context, index){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(
            height: 0.0,
            thickness: 3,
          ),
        );
      }, 
      itemCount: _dataMenu.length
    );
  }
}

class SettingsDataSectionWidget extends StatelessWidget {
  SettingsDataSectionWidget({
    super.key,
    required String label,
    required List dataMenu
  }) : _label = label,
       _dataMenu = dataMenu;

  final String _label;
  final List _dataMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _label,
            style: TextStyleConfig.body1bold,
          ),
          ListView.separated(
            itemCount: _dataMenu.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16.0,);
            },
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return SettingsDataListItem(
                menu: _dataMenu[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsDataListItem extends StatelessWidget {
  SettingsDataListItem({
    super.key,
    required String menu
  }) : _menu = menu;

  final String _menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: ColorConfig.mainColor,
            offset: Offset(2, 2),
            blurRadius: 1
          )
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){

          },
          splashColor: Colors.black.withAlpha(25),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              _menu,
              style: TextStyleConfig.body1,
            ),
          ),
        ),
      ),
    );
  }
}