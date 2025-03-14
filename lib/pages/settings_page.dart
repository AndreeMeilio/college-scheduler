import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/pages/change_fullname_username_page.dart';
import 'package:college_scheduler/pages/change_password_page.dart';
import 'package:college_scheduler/pages/data_class_page.dart';
import 'package:college_scheduler/pages/login_history_page.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
            const SizedBox()
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
        "item": List.from(<Map>[
          {
            "name": "History Event",
            "isFeatureIncoming" : true
          },
          {
            "name": "Data Class",
            "isFeatureIncoming": false
          },
          {
            "name": "Data Dosen",
            "isFeatureIncoming": true
          },
          {
            "name": "Files",
            "isFeatureIncoming": true
          },
        ])
      },
      {
        "label" : "Notification",
        "item": List.from(<Map>[
          {
            "name": "Reminder Event",
            "isFeatureIncoming": true
          },
          {
            "name": "Reminder Input",
            "isFeatureIncoming": true
          }
        ])
      },
      {
        "label" : "Account",
        "item" : List.from(<Map>[
          {
            "name": "Change Password",
            "isFeatureIncoming": false
          },
          {
            "name": "Login History",
            "isFeatureIncoming": false
          },
          {
            "name": "Change Fullname Or Username",
            "isFeatureIncoming": false
          },
          {
            "name": "Logout",
            "isFeatureIncoming": false
          }
        ])
      }
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
                onTap: () async{
                  if (_dataMenu[index]["name"] == "Logout"){
                    final prefs = SharedPreferenceConfig();

                    await prefs.clearShared();

                    if (context.mounted){
                      Navigator.pushReplacement(context, PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: LoginPage()
                      ));
                    }
                  } else if (_dataMenu[index]["name"] == "Data Class"){
                    Navigator.push(context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DataClassPage()
                    ));
                  } else if (_dataMenu[index]["name"] == "Change Password"){
                    Navigator.push(context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChangePasswordPage()
                    ));
                  } else if (_dataMenu[index]["name"] == "Change Fullname Or Username"){
                    Navigator.push(context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChangeFullnameUsernamePage()
                    ));
                  } else if (_dataMenu[index]["name"] == "Login History"){
                    Navigator.push(context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: LoginHistoryPage()
                    ));
                  }
                },
                menu: _dataMenu[index]["name"],
                isFeatureIncoming: _dataMenu[index]["isFeatureIncoming"],
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
    required String menu,
    required void Function()? onTap,
    bool? isFeatureIncoming

  }) : _menu = menu,
       _onTap = onTap,
       _isFeatureIncoming = isFeatureIncoming;

  final String _menu;
  final void Function()? _onTap;
  final bool? _isFeatureIncoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isFeatureIncoming ?? false ? Colors.grey : Colors.white,
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
        child: _isFeatureIncoming ?? false
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _menu,
                      style: TextStyleConfig.body1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorConfig.mainColor),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Text(
                      "Incoming",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ],
              )
            )
          : InkWell(
              onTap: _onTap,
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