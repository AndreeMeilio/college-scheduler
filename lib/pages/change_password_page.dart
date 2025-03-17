
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/change_password_cubit.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  late bool isOldPasswordObscure;
  late bool isNewPasswordObscure;
  late bool isConfirmNewPasswordObscure;

  late ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    isOldPasswordObscure = true;
    isNewPasswordObscure = true;
    isConfirmNewPasswordObscure = true;

    _cubit = BlocProvider.of<ChangePasswordCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Column(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  spacing: 24.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _oldPasswordController,
                      label: "Old Password",
                      hint: "Input your old password",
                      isPassword: true,
                      isRequired: true,
                      obsureText: isOldPasswordObscure,
                      suffixIconOnPressed: (){
                        setState(() {
                          isOldPasswordObscure = !isOldPasswordObscure;
                        });
                      },
                      validator: (value){

                      },
                    ),
                    CustomTextFormField(
                      controller: _newPasswordController,
                      label: "New Password",
                      hint: "Input your new password",
                      isPassword: true,
                      isRequired: true,
                      obsureText: isNewPasswordObscure,
                      suffixIconOnPressed: (){
                        setState(() {
                          isNewPasswordObscure = !isNewPasswordObscure;
                        });
                      },
                      validator: (value){
                        if (!(value?.isNotEmpty ?? false)){
                          return "Please input your Password";
                        } else if (!(_newPasswordController.text.length >= 8)){
                          return "Password Must Up To 8 Characters";
                        } else if (!(_newPasswordController.text.contains(RegExp(r'[0-9]+')))) {
                          return "Password Must Contain Atleats One Number";
                        } else if (!(_newPasswordController.text.contains(RegExp(r'[^\w\s]')))){
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
                      password: _newPasswordController.text,
                    ),
                    CustomTextFormField(
                      controller: _confirmNewPasswordController,
                      label: "Confirm New Password",
                      hint: "Input confirmation of new password",
                      isPassword: true,
                      isRequired: true,
                      obsureText: isConfirmNewPasswordObscure,
                      suffixIconOnPressed: (){
                        setState(() {
                          isConfirmNewPasswordObscure = !isConfirmNewPasswordObscure;
                        });
                      },
                      validator: (value){

                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<ChangePasswordCubit, StateGeneral>(
            builder: (context, state){
              return PrimaryButtonComponent(
                label: "Submit",
                isLoading: state.state is ChangePasswordLoadingState,
                onTap: () async{
                  if (_key.currentState?.validate() ?? false){
                    await _cubit.changePassword(
                      oldPassword: _oldPasswordController.text, 
                      newPassword: _newPasswordController.text
                    );
                  } else {
                    toastification.show(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 3),
                      style: ToastificationStyle.fillColored,
                      type: ToastificationType.error,
                      title: Text("Register Failed"),
                      description: Text("Please fill the required field"),
                      primaryColor: Colors.red
                    );
                  }
                },
              );
            },
            listener: (context, state) async{
              if (state.state is ChangePasswordSuccessState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.success,
                  title: Text("Register Success"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.green
                );

                final prefs = SharedPreferenceConfig();

                await prefs.clearShared();

                if (context.mounted){
                  Navigator.pushReplacement(context, PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: LoginPage()
                  ));
                }
              } else if (state.state is ChangePasswordFailedState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.error,
                  title: Text("Register Failed"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.red
                );
              }
            },
          ),
          const SizedBox()
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
                Expanded(
                  child: Text(
                    _passwordRule[key]["label"],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _passwordRule[key]["activate"] ? ColorConfig.mainColor : Colors.grey,
                    ),
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