import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  static ProfileController? _instance;

  static ProfileController getInstance() {
    _instance ??= ProfileController();
    return _instance!;
  }

  TextEditingController profileEmail = TextEditingController();
  TextEditingController profileLanguage = TextEditingController();

}