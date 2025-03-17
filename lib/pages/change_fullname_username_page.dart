
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/change_fullname_username_cubit.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class ChangeFullnameUsernamePage extends StatefulWidget {
  const ChangeFullnameUsernamePage({super.key});

  @override
  State<ChangeFullnameUsernamePage> createState() => _ChangeFullnameUsernamePageState();
}

class _ChangeFullnameUsernamePageState extends State<ChangeFullnameUsernamePage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _fullnameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late bool _isObscure;

  late ChangeFullnameUsernameCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _isObscure = true;

    _cubit = BlocProvider.of<ChangeFullnameUsernameCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Fullname Or Username",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24.0,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _fullnameController,
                      label: "Fullname",
                      hint: "Input your new Fullname",
                      isRequired: true,
                      validator: (value){
                        if (value?.isEmpty ?? false){
                          return "Please input your new fullname";
                        }

                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: _usernameController,
                      label: "Username",
                      hint: "Input your new Username",
                      isRequired: true,
                      validator: (value){
                        if (value?.isEmpty ?? false){
                          return "Please input your new username";
                        }

                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      label: "Password",
                      hint: "Input your password for validation account",
                      isRequired: true,
                      isPassword: true,
                      obsureText: _isObscure,
                      suffixIconOnPressed: (){
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      validator: (value){
                        if (value?.isEmpty ?? false){
                          return "Please input your password for security purpose";
                        }

                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "For security purpose, please insert your account password, so that we can know this is you who trying to change the username",
                        style: TextStyleConfig.body1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<ChangeFullnameUsernameCubit, ChangeFullnameUsernameStateType>(
            builder: (context, state){
              return PrimaryButtonComponent(
                onTap: () async{
                  if (_key.currentState?.validate() ?? false){
                    await _cubit.changeFullnameUsername(
                      fullname: _fullnameController.text,
                      username: _usernameController.text,
                      password: _passwordController.text
                    );

                    final prefs = SharedPreferenceConfig();

                    await prefs.clearShared();

                    if (context.mounted){
                      Navigator.pushReplacement(context, PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: LoginPage()
                      ));
                    }
                  } else {
                    toastification.show(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 3),
                      style: ToastificationStyle.fillColored,
                      type: ToastificationType.error,
                      title: Text("Change Fullname or Username Failed"),
                      description: Text("Please fill the required data"),
                      primaryColor: Colors.red
                    ); 
                  }
                },
                label: "Submit Changes",
              );
            },
            listener: (context, state){
              if (state.state is ChangeFullnameUsernameSuccessState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.success,
                  title: Text("Change Fullname or Username Success"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.green
                ); 
              } else if (state.state is ChangeFullnameUsernameFailedState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.error,
                  title: Text("Change Fullname or Username Failed"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.red
                );
              }
            },
          ),
          const SizedBox()
        ],
      ),
    );
  }
}