
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastNotifUtils{
  static void showError({
    required BuildContext context,
    required String title,
    required String description
  }){
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      type: ToastificationType.error,
      title: Text(title, style: TextStyleConfig.body1bold,),
      description: Text(description, style: TextStyleConfig.body1,),
      primaryColor: Colors.red
    ); 
  }

  static void showSuccess({
    required BuildContext context,
    required String title,
    required String description
  }) {
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      type: ToastificationType.success,
      title: Text(title, style: TextStyleConfig.body1bold,),
      description: Text(description, style: TextStyleConfig.body1,),
      primaryColor: Colors.green
    ); 
  }
}