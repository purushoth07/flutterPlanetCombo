import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetcombo/common/widgets.dart';

import 'package:planetcombo/api/api_callings.dart';

class ApiCallingsController extends GetxController {
  static ApiCallingsController? _instance;

  static ApiCallingsController getInstance() {
    _instance ??= ApiCallingsController();
    return _instance!;
  }

  socialLogin(email, medium, password, tokenId, BuildContext context) async{
    var response = await APICallings.socialLogin(email: email, medium: medium, password: password, tokenId: tokenId);
    return response;
  }

}