
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationComponent extends StatelessWidget {
  const DeleteConfirmationComponent({
    super.key,
    required this.onCancel,
    required this.onProcceed
  });

  final dynamic Function()? onCancel;
  final dynamic Function()? onProcceed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              "Delete Confirmation!",
              style: TextStyleConfig.body1bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "The deleted data cannot be restored, Are you sure you want to delete it?",
              style: TextStyleConfig.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButtonComponent(
                label: "Cancel",
                color: Colors.grey,
                width: MediaQuery.sizeOf(context).width * 0.25,
                onTap: onCancel
              ),
              PrimaryButtonComponent(
                label: "Yes, Delete It",
                color: ColorConfig.mainColor,
                width: MediaQuery.sizeOf(context).width * 0.25,
                onTap: onProcceed
              ),
            ],
          )
        ],
      ),
    );
  }
}