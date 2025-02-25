import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_button_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late GlobalKey<FormState> _formRegister;
  late TextEditingController _fullnameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late bool _isObscure;

  @override
  void initState() {
    super.initState();

    _formRegister = GlobalKey<FormState>();
    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _isObscure = true;
  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.clear();
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          "Register"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formRegister,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24.0,
                  children: [
                    CustomTextFormField(
                      controller: _fullnameController,
                      label: "Fullname",
                      hint: "Input your Fullname",
                      validator: (value){
                        if (!(value?.isNotEmpty ?? false)){
                          return "Please input your Fullname";
                        }
                    
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: _usernameController,
                      label: "Username",
                      hint: "Input your Username",
                      validator: (value){
                        if (!(value?.isNotEmpty ?? false)){
                          return "Please input your Username";
                        }
                    
                        return null;
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 16.0,
                      children: [
                        CustomTextFormField(
                          controller: _passwordController,
                          label: "Password",
                          hint: "Input your Password",
                          isPassword: true,
                          obsureText: _isObscure,
                          suffixIconOnPressed: (){
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          validator: (value){
                            if (!(value?.isNotEmpty ?? false)){
                              return "Please input your Password";
                            } else if (!(_passwordController.text.length >= 8)){
                              return "Password Must Up To 8 Characters";
                            } else if (!(_passwordController.text.contains(RegExp(r'[0-9]+')))) {
                              return "Password Must Contain Atleats One Number";
                            } else if (!(_passwordController.text.contains(RegExp(r'[^\w\s]')))){
                              return "Password Must Contain Symbol";
                            }
                        
                            return null;
                          },
                          onChanged: (value){
                            setState(() {
                              
                            });
                          },
                        ),
                        PasswordRuleChecker(
                          password: _passwordController.text,
                        )
                      ]
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0,),
          PrimaryButtonComponent(
            onTap: (){
              if (_formRegister.currentState?.validate() ?? false){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.success,
                  primaryColor: Colors.green,
                  title: Text("Register Successed"),
                  description: Text("Continue login using your account!")
                );
                Navigator.pop(context);
              } else {
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.error,
                  title: Text("Register Failed"),
                  description: Text("Please fill the required data"),
                  primaryColor: Colors.red
                );
              }
            },
            label: "Register Account",
          ), 
          TextButtonComponent(
            label: "Already Have Account? Login Here!",
            onTap: (){
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 24.0,),
        ],
      )
    );
  }
}

class PasswordRuleChecker extends StatelessWidget {
  PasswordRuleChecker({
    super.key,
    required String password
  }) : _password = password;

  final Map<String, dynamic> _passwordRule = Map.from({
    "firstRule" : Map.from({
      "label": "Password Must Up To 8 Characters",
      "activate" : false
    }),
    "secondRule" : Map.from({
      "label" : "Password Must Contain Atleast One Number",
      "activate" : false
    }),
    "thirdRule" : Map.from({
      "label" : "Password Must Contain Symbol",
      "activate" : false 
    }),
  });

  final String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _passwordRule.keys.map<Widget>((key){
          if (key == "firstRule"){
            _passwordRule[key]["activate"] = _password.length >= 8;
          } else if (key == "secondRule") {
            _passwordRule[key]["activate"] = _password.contains(RegExp(r'[0-9]+'));
          } else if (key == "thirdRule") {
            _passwordRule[key]["activate"] = _password.contains(RegExp(r'[^\w\s]'));
          }
          
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: _passwordRule[key]["activate"] ? ColorConfig.mainColor : Colors.grey,),
                const SizedBox(width: 16.0,),
                Text(
                  _passwordRule[key]["label"],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _passwordRule[key]["activate"] ? ColorConfig.mainColor : Colors.grey,
                  ),
                )
              ],
            ),
          );
        }).toList()
      )
    );
  }
}