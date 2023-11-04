import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synapsis_test/app/data/constraint/font_style.dart';

class MyTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final RxBool showPassIcon;

  final RxBool showText = false.obs;

  TextEditingController controller;

  MyTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.showPassIcon,
    required this.controller,
  }) : super(key: key);

  void toggleSuffixIcon() {
    showText.value = !showText.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 43,
        child: TextField(
          style: interFont.copyWith(
              color: Color(0xFF757575),
              fontSize: 15,
              fontWeight: FontWeight.w400),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Color(0xFF777777)),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD6E4EC)),
                borderRadius: BorderRadius.circular(4)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD6E4EC)),
                borderRadius: BorderRadius.circular(4)),
            suffixIcon: showPassIcon.value
                ? IconButton(
                    icon: Icon(
                        showText.value ? Icons.visibility_off : Icons.visibility),
                    color: Color(0xFF9DA7AD),
                    onPressed: toggleSuffixIcon,
                  )
                : null, // Return null when hideSuffixIcon is true.
          ),
          obscuringCharacter: "*",
          obscureText: obscureText && !showText.value,
        ),
      );
    });
  }
}
