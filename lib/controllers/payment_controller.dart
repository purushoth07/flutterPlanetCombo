import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:planetcombo/common/common_callings.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/api/api_callings.dart';
import 'package:planetcombo/common/constant.dart';

class PaymentController extends GetxController {
  static PaymentController? _instance;

  static PaymentController getInstance() {
    _instance ??= PaymentController();
    return _instance!;
  }

  Constants constants = Constants();

  void addOfflineMoney(userId, email, amount, token, context) async{
      CustomDialog.showLoading(context, 'Please wait');
      var response = await APICallings.addOfflineMoney(currency: constants.currency, token: token, amount: amount, email: email, userId: userId);
      print(response);
      CustomDialog.cancelLoading(context);
  }

}