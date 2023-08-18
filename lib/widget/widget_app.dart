import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetApp {
  Widget textFieldApp({
    required TextEditingController controller,
    required TextInputType textInputType,
    Widget? label,
    String? hint,
    double borderRadius = 5,
    Color? colorFill,
    void Function()? onPressSuffix,
    IconData? suffixIcon,
    bool? obscureText,
    InputBorder? border,
  }) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText :hint,
        label: label,
        border: border ?? borderTextField(borderRadius: borderRadius),
        fillColor: colorFill,
        filled: colorFill == null ? false : true,
        suffixIcon: IconButton(
          onPressed: onPressSuffix,
          icon: Icon(suffixIcon),
        ),
      ),
      obscureText: obscureText ?? false,
    );
  }

  InputBorder borderTextField({required double borderRadius}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );
  }
  Widget buttonApp({
    required void Function()? onPress,
    required Color foregroundColor,
    required Color backgroundColor,
    double elevation = 4,
    required double width,
    required double height,
    double borderRadius = 5,
    required Widget childButton,
  }) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        elevation: elevation,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
      child: childButton,
    );
  }

  PreferredSizeWidget? appBarApp({
    String? title,
    List<Widget>? action,
  }) {
    return AppBar(
      title: Text('$title'),
      actions: action,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}
