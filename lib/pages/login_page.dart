import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_button_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/pages/register_page.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _isPassword = true;
    _obsureText = true;
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
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        decoration: const BoxDecoration(
                          color: ColorConfig.mainColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.0),
                            bottomRight: Radius.circular(24.0)
                          )
                        ),
                        child: Image.asset(
                          "assets/appointment.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: const Text(
                          "COLLEGE SCHEDULER",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
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
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButtonComponent(
                    onTap: (){
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
                  TextButtonComponent(
                    label: "Or Register Here!",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const RegisterPage()
                      ));
                    },
                  ),
                ]
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}