import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/di_config.dart';
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