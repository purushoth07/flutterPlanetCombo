import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetcombo/controllers/apiCalling_controllers.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:planetcombo/models/horoscope_list.dart';
import 'package:planetcombo/api/api_callings.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ApplicationBaseController extends GetxController {
  static ApplicationBaseController? _instance;

  static ApplicationBaseController getInstance() {
    _instance ??= ApplicationBaseController();
    return _instance!;
  }

  RxList<HoroscopesList> horoscopeList = <HoroscopesList>[].obs;


  RxBool horoscopeListPageLoad = false.obs;

  RxString termsAndConditionsLink = ''.obs;

  RxString getTimeZone = ''.obs;

  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  final ApiCallingsController apiCallingsController =
  Get.put(ApiCallingsController.getInstance(), permanent: true);

  void initializeApplication(){
    _getUserHoroscopeList();
    _getTermsAndConditions();
    _getTimeZone();
  }

  _getTimeZone(){
    getTimezone();
  }

  void getTimezone(){
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;
    getTimeZone.value = formatDuration(offset);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.isNegative) {
      return '-${twoDigits(duration.inHours)}${twoDigitMinutes}${twoDigitSeconds}';
    } else {
      return '${twoDigits(duration.inHours)}${twoDigitMinutes}${twoDigitSeconds}';
    }
  }

  getUserHoroscopeList(){
    _getUserHoroscopeList();
  }


  getUserWallet(){
    _getUserWallet();
  }

  _getUserWallet() async{
    try{
      var response = await APICallings.termsAndConditions(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      print('the response is ');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {
          termsAndConditionsLink.value = jsonBody['Data'];
        }
      }
    }catch(error){
      print('terms and conditions have api reach error');
      print(error);
    }
  }

  getTermsAndConditions(){
    _getTermsAndConditions();
  }

  _getTermsAndConditions() async{
    try{
      var response = await APICallings.termsAndConditions(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      print('the response is ');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {
          termsAndConditionsLink.value = jsonBody['Data'];
        }
      }
    }catch(error){
      print('terms and conditions have api reach error');
      print(error);
    }
  }

  _getUserHoroscopeList() async{
    try{
      horoscopeListPageLoad.value = true;
      var response = await APICallings.getHoroscope(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      horoscopeListPageLoad.value = false;
      print("Get Horoscope List Response : $response");
      if (response != null) {
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {
          if(jsonBody['Data'] == null){
            print('the length of the horoscopes ${horoscopeList.length}');
            horoscopeList.value = [];
          }else{
            horoscopeList.value = horoscopesListFromJson(response);
            print('the length of the horoscopes ${horoscopeList.length}');
          }
        } else {
          horoscopeList.value = [];
          print(jsonBody['Message']);
        }
      }
    }finally {}
  }

}