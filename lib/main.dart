import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/di_config.dart';
import 'package:college_scheduler/cubit/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/class/create_and_update_data_class_cubit.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/cubit/event/list_event_cubit.dart';
import 'package:college_scheduler/cubit/users/login_cubit.dart';
import 'package:college_scheduler/cubit/users/register_cubit.dart';
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
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(usersLocalData: sl()),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(usersLocalData: sl()),
        ),
        BlocProvider<CreateAndUpdateEventCubit>(
          create: (context) => CreateAndUpdateEventCubit(eventLocalData: sl()),
        ),
        BlocProvider<ListEventCubit>(
          create: (context) => ListEventCubit(eventLocalData: sl()),
        ),
        BlocProvider<CreateAndUpdateDataClassCubit>(
          create: (context) => CreateAndUpdateDataClassCubit(classLocalData: sl()),
        ),
        BlocProvider<ListDataClassCubit>(
          create: (context) => ListDataClassCubit(classLocalData: sl()),
        ),
        BlocProvider<BaseMenuCubit>(
          create: (context) => BaseMenuCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Jadwal Kuliah',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConfig.mainColor),
          useMaterial3: true,
          fontFamily: "LibreBaskerville",
          scaffoldBackgroundColor: ColorConfig.backgroundColor
        ),
        home: LoginPage()
      ),
    );
  }
}