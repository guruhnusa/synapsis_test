import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synapsis_test/app/data/services/api_services.dart';
import 'package:synapsis_test/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //
  final box = GetStorage();

  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();

  TextEditingController get email => _email;
  TextEditingController get password => _password;

  RxBool _rememberMe = false.obs;

  bool get rememberMe => _rememberMe.value;

  void toggleRemember() {
    _rememberMe.toggle();
    print("Remember:$rememberMe");
  }

  @override
  void onInit() {
    super.onInit();
    if (box.read('users') != null) {
      final data = box.read('users') as Map<String, dynamic>;
      email.text = data["email"];
      password.text = data["password"];
      _rememberMe.value = data["remember"];
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void login(String email, String password, bool rememberMe) async {
    var response = await ApiService.login(email, password);
    if (response == 200) {
      if (_rememberMe.isTrue) {
        box.write('users',
            {'email': email, 'password': password, 'remember': rememberMe});
        print("REMEMBER TRUE");
      } else {
        if (box.read('users') != null) {
          box.erase();
        }
      }
      print("Success Login");
      Get.offAllNamed(Routes.HOME);
    }
    else{
      Get.snackbar("Login Failed", "Check Your Email and Password again",
          duration: Duration(seconds: 1));
    }
  }



}
