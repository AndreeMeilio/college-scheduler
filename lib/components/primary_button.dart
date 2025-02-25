import 'package:college_scheduler/config/color_config.dart';
import 'package:flutter/material.dart';

class PrimaryButtonComponent extends StatelessWidget {
  PrimaryButtonComponent({
    super.key,
    required Function()? onTap,
    required String label
  }) : _onTap = onTap,
       _label = label;

  final Function()? _onTap;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onTap,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          splashColor: Colors.white24,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            alignment: Alignment.center,
            child: Text(
              _label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}