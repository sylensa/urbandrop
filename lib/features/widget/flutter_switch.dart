import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class OnAndOffSwitch extends StatelessWidget {
  const OnAndOffSwitch(
      {super.key,
        required this.onToggle,
        required this.value,
        this.height = 40,
        this.width = 90,
        this.toggleSize = 30,
        this.padding = 6,
        this.disabled = false,
        this.inactiveColor = greyText,
        this.activeColor = Colors.white,
        this.toggleColor = primaryColor,
      });
  final Function(bool val) onToggle;
  final bool value;
  final bool disabled;
  final double width;
  final double height;
  final double toggleSize;
  final double padding;
  final Color inactiveColor;
  final Color activeColor;
  final Color toggleColor;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      toggleSize: toggleSize,
      disabled: disabled,
      width: width,
      height: height,
      toggleColor: toggleColor,
      value: value,
      onToggle: onToggle,
      showOnOff: false,
      padding: padding,
      activeTextColor: Colors.white,
      activeTextFontWeight: FontWeight.w500,
      inactiveTextFontWeight: FontWeight.w500,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
    );
  }
}
