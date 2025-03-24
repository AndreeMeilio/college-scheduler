import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/cubit_config.dart';
import 'package:college_scheduler/config/di_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/generated/app_localizations_en.dart';
import 'package:college_scheduler/config/generated/app_localizations_id.dart';
import 'package:college_scheduler/config/route_navigator_config.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CubitConfig.getProviders(),
      child: MaterialApp.router(
        title: 'Jadwal Kuliah',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConfig.mainColor),
          useMaterial3: true,
          fontFamily: "LibreBaskerville",
          scaffoldBackgroundColor: ColorConfig.backgroundColor
        ),
        routerConfig: RouteNavigatorConfig.router,
      ),
    );
  }
}