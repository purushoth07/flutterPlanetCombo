import 'dart:convert';
import 'package:get/get.dart';
import 'package:planetcombo/controllers/apiCalling_controllers.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:planetcombo/models/horoscope_list.dart';
import 'package:planetcombo/models/messages_list.dart';
import 'package:planetcombo/api/api_callings.dart';

class ApplicationBaseController extends GetxController {
  static ApplicationBaseController? _instance;

  static ApplicationBaseController getInstance() {
    _instance ??= ApplicationBaseController();
    return _instance!;
  }

  RxList<HoroscopesList> horoscopeList = <HoroscopesList>[].obs;

  RxList<MessageHistory> messagesHistory = <MessageHistory>[].obs;

  Rx<MessagesList> messagesInfo = MessagesList().obs;

  RxBool horoscopeListPageLoad = false.obs;

  RxString termsAndConditionsLink = ''.obs;

  RxString getTimeZone = ''.obs;

  RxDouble userAccountBalance = 12.0.obs;

  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  final ApiCallingsController apiCallingsController =
  Get.put(ApiCallingsController.getInstance(), permanent: true);

  void initializeApplication(){
    _getUserHoroscopeList();
    _getTermsAndConditions();
    _getTimeZone();
    _getUserMessages();
    _getUserPredictions();
    _getUserWallet();
    _getInvoiceList();
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

  getUserMessages(){
    _getUserMessages();
  }

  getUserPredictions(){
    _getUserPredictions();
  }

  _getUserMessages() async{
    try{
      var response = await APICallings.getUserMessages(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      print('the response is ');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {
          print('iam launching here $response');
             messagesInfo.value = messagesListFromJson(response);
             messagesHistory.value = messagesInfo.value.data!;
          print('the recevied value of messages is ${messagesHistory.length}');
        }
      }
    }catch(error){
      print('Get all user messages error section reached');
      print(error);
        messagesHistory.value = [];
        print('the length of the message history is ${messagesHistory.length}');
    }
  }

  _getUserPredictions() async{
    try{
      var response = await APICallings.getUserPredictions(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      print('the response is ');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {

        }
      }
    }catch(error){
      print('terms and conditions have api reach error');
      print(error);
    }
  }

  _getUserWallet() async{
    try{
      // Get the current date
      DateTime currentDate = DateTime.now();

      // Extract the month and year
      String month = currentDate.month.toString().padLeft(2, '0');
      String year = currentDate.year.toString().substring(2);

      // Combine month and year
      String formattedDate = month + year;
      var response = await APICallings.getWalletBalance(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!, statementSEQ: formattedDate);
      print('the response of the wallet balance is');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {
          print('the received user balance is $userAccountBalance');
          userAccountBalance.value = jsonBody['CloseCurrentBalance']['ACCOUNTBAL'];
          print('the received user balance is $userAccountBalance');
          // termsAndConditionsLink.value = jsonBody['Data'];
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

  _getInvoiceList() async{
    try{
      var response = await APICallings.getInvoiceList(userId: appLoadController.loggedUserData.value.userid!, token: appLoadController.loggedUserData.value.token!);
      print('the response is ');
      print(response);
      if(response != null){
        var jsonBody = json.decode(response);
        if (jsonBody['Status'] == 'Success') {

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