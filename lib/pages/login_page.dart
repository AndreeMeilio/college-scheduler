import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_button_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users_cubit.dart';
import 'package:college_scheduler/pages/base_page.dart';
import 'package:college_scheduler/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  late bool _isPassword;
  late bool _obsureText;

  late UsersCubit _cubit;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _isPassword = true;
    _obsureText = true;

    _cubit = BlocProvider.of<UsersCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.0,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24.0,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        decoration: const BoxDecoration(
                          color: ColorConfig.mainColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.0),
                            bottomRight: Radius.circular(24.0)
                          )
                        ),
                        child: Column(
                          spacing: 16.0,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\"THE PATH TO PARADISE BEGINS IN HELL\"",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic
                              ),
                            ),
                            Text(
                              "~ Dante Alighieri",
                              style: TextStyleConfig.heading1.copyWith(
                                fontStyle: FontStyle.italic
                              ),
                            ),
                          ],
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "COLLEGE SCHEDULER",
                          style: TextStyleConfig.heading1bold
                        ),
                      ),
                      CustomTextFormField(
                        controller: _usernameController,
                        hint: "Input your username",
                        label: "Username",
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return "Please input your account username";
                          }
                
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        hint: "Input your password",
                        label: "Password",
                        obsureText: _obsureText,
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return "Please input your account password";
                          }
                
                          return null;
                        },
                        isPassword: _isPassword,
                        suffixIconOnPressed: (){
                          setState(() {
                            _obsureText = !_obsureText;
                          });
                        },
                      ),
                      BlocConsumer<UsersCubit, UserState>(
                        builder: (context, state) {
                          return Container();
                        },
                        listener: (context, state) {
                          if (state is UserFailedState){
                            print(state.message);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.0,
                children: [
                  PrimaryButtonComponent(
                    onTap: () async{
                      if (_formKey.currentState?.validate() ?? false){
                        toastification.show(
                          context: context,
                          autoCloseDuration: const Duration(seconds: 3),
                          style: ToastificationStyle.fillColored,
                          type: ToastificationType.success,
                          title: Text("Login Successed"),
                          description: Text("Welcome home Sir!"),
                          primaryColor: Colors.green
                        );

                        // Navigator.pushReplacement(context, PageTransition(
                        //   type: PageTransitionType.rightToLeft,
                        //   child: BasePage()
                        // ));
                        
                        await _cubit.getAllData();
                      } else {
                        toastification.show(
                          context: context,
                          autoCloseDuration: const Duration(seconds: 3),
                          style: ToastificationStyle.fillColored,
                          type: ToastificationType.error,
                          title: Text("Login Failed"),
                          description: Text("Account doesn't exist"),
                          primaryColor: Colors.red
                        );
                      }
                    },
                    label: "Login",
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 250),
                        child: RegisterPage()
                      ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't Have Account? ",
                          style: TextStyleConfig.body1.copyWith(
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(
                              text: "Register Here",
                              style: TextStyleConfig.body1.copyWith(
                                color: ColorConfig.mainColor
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 24.0,),
            ],
          ),
        ),
      ),
    );
  }
}