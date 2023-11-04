import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:synapsis_test/app/data/constraint/color.dart';
import 'package:synapsis_test/app/data/constraint/font_style.dart';
import 'package:synapsis_test/app/data/widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
            children: [
              Text("Login to Synapsis",
                  style: interFont.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: primaryColors)),
              const SizedBox(
                height: 34,
              ),
              Text(
                "Email",
                style: interFont.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB9B9B9)),
              ),
              const SizedBox(
                height: 4,
              ),
              MyTextField(
                  hintText: "Enter Your Email",
                  obscureText: false,
                  showPassIcon: RxBool(false),
                  controller: controller.email),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Password",
                style: interFont.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFB9B9B9)),
              ),
              const SizedBox(
                height: 4,
              ),
              MyTextField(
                  hintText: "Enter Your Passsword",
                  obscureText: true,
                  showPassIcon: RxBool(true),
                  controller: controller.password),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return CheckboxListTile(
                  side: const BorderSide(color: Color(0xFFD0D7DE), width: 1),
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Remember me",
                      style: interFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color(0XFF757575))),
                  value: controller.rememberMe,
                  onChanged: (value) {
                    controller.toggleRemember();
                  },
                );
              }),
              const SizedBox(
                height: 48,
              ),
              SizedBox(
                height: 43,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF1FA0C9)),
                    onPressed: () {
                      controller.login(controller.email.text,
                          controller.password.text, controller.rememberMe);
                    },
                    child: Text(
                      "Log in",
                      style: interFont.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                    child: Text(
                  "Or",
                  style: interFont.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFF1FA0C9)),
                )),
              ),
              SizedBox(
                height: 43,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0XFF1FA0C9), width: 1)),
                    onPressed: () {},
                    child: Text(
                      "Fingerprint",
                      style: interFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFF1FA0C9)),
                    )),
              ),
            ],
          ),
        ));
  }
}
