import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetcombo/models/social_login.dart';

class AppLoadController extends GetxController {
  static AppLoadController? _instance;

  static AppLoadController getInstance() {
    _instance ??= AppLoadController();
    return _instance!;
  }

  Color appPrimaryColor = const Color(0xffed5b30);
  Color appSecondaryColor = const Color(0xfff2b20a);
  Color appMidColor = const Color(0xfff48100);

  Rx<SocialLoginData> loggedUserData = SocialLoginData().obs;

  RxString addNewUser = 'No'.obs;
}

