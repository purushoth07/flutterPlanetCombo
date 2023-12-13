import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:planetcombo/api/api_callings.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/applicationbase_controller.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:planetcombo/controllers/add_horoscope_controller.dart';
import 'package:get/get.dart';
import 'package:planetcombo/screens/Requests/planet_transit.dart';
import 'package:planetcombo/screens/services/add_nativePhoto.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:planetcombo/screens/promise.dart';
import 'package:planetcombo/controllers/request_controller.dart';

import 'package:planetcombo/screens/Requests/daily_prediction.dart';
import 'package:planetcombo/screens/Requests/special_prediction.dart';


class HoroscopeServices extends StatefulWidget {
  const HoroscopeServices({Key? key}) : super(key: key);

  @override
  _HoroscopeServicesState createState() => _HoroscopeServicesState();
}

class _HoroscopeServicesState extends State<HoroscopeServices> {
  final double width = 32;
  final double height = 32;

  final LocalizationController localizationController =
  Get.put(LocalizationController.getInstance(), permanent: true);

  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  final ApplicationBaseController applicationBaseController =
  Get.put(ApplicationBaseController.getInstance(), permanent: true);

  final HoroscopeRequestController horoscopeRequestController =
  Get.put(HoroscopeRequestController.getInstance(), permanent: true);

  final AddHoroscopeController addHoroscopeController =
  Get.put(AddHoroscopeController.getInstance(), permanent: true);

  void deleteHoroscope(String userId, String hid) async{
    CustomDialog.showLoading(context, 'Please wait');
    var result = await APICallings.deleteHoroscope(userId: userId, hId: hid.trim(), token: appLoadController.loggedUserData!.value.token!);
    CustomDialog.cancelLoading(context);
    var jsondata = jsonDecode(result!);
    print('The recevied result is $jsondata');
    applicationBaseController.getUserHoroscopeList();
  }

  void viewHoroscope(String userId, String hid) async{
    CustomDialog.showLoading(context, 'Please wait');
    var result = await APICallings.viewHoroscopeChart(userId: userId, hId: hid.trim(), token: appLoadController.loggedUserData!.value.token!);
    print('the value of result is $result');
    CustomDialog.cancelLoading(context);
    var jsondata = jsonDecode(result!);
    print('The recevied chart is ${jsondata['Status']}');
    if(jsondata['Status'] == 'Success'){
      if(jsondata['Data'] == 'undefined' || jsondata['Data'] == null){
        CustomDialog.showAlert(context, 'Chart does not exist', false, 14);
      }else{
          String htmlLink = jsondata['Data'];
          if (!await launchUrl(Uri.parse(htmlLink))) {
            throw Exception('Could not launch $htmlLink');
          }
      }
    }
  }

  void emailHoroscope(String userId, String hid) async{
    CustomDialog.showLoading(context, 'Please wait');
    var result = await APICallings.emailChart(userId: userId, hId: hid.trim(), token: appLoadController.loggedUserData!.value.token!);
    print('the value of result is $result');
    CustomDialog.cancelLoading(context);
    if(result == '403 Server error'){
      CustomDialog.showAlert(context, result!, false, 14);
    }else if(result == 'Something went wrong' || result == null){
      CustomDialog.showAlert(context, result!, false, 14);
    }else{
        var jsonData = json.decode(result);
        if(jsonData['Status'] == 'Failure'){
          CustomDialog.showAlert(context, jsonData['ErrorMessage'], false, 14);
        }else{
          CustomDialog.showAlert(context, jsonData['Message'], true, 14);
        }
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext buttonContext){
      return WillPopScope(
        onWillPop: () async{
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
                (Route<dynamic> route) => false,
          );
          return true;
        },
        child: Scaffold(
          appBar: GradientAppBar(
            leading: IconButton(onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
                    (Route<dynamic> route) => false,
              );
            }, icon: const Icon(Icons.chevron_left_rounded),),
            title: LocalizationController.getInstance().getTranslatedValue("Horoscope Services"),
            colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
          ),
          body: Obx(() =>
              applicationBaseController.horoscopeListPageLoad.value == true ? const Center(child: CircularProgressIndicator()):
              Column(
            children: [
              Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: localizationController.currentLanguage.value == 'ta' ? 215 : 165,
                        child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Add Horoscope"), textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset) {
                          addHoroscopeController.refreshAlerts();
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const AddNativePhoto()));
                        }, materialIcon: Icons.add, materialIconSize: 21)),
                    const SizedBox(width: 15)
                  ],
                ),
              ),
              applicationBaseController.horoscopeList.isEmpty ? Expanded(
                child: Center(
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: commonText(
                        textAlign: TextAlign.center,
                        text: 'Horoscope list is empty, please click the add button to add horoscope',
                        color: Colors.black26, fontSize: 12
                    ),
                  ),
                ),
              ): Expanded(
                child: ListView.builder(
                  itemCount: applicationBaseController.horoscopeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.2, // Specify the thickness of the border
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: applicationBaseController.horoscopeList[index].hnativephoto!,
                                    width: width,
                                    height: height,
                                    placeholder: (context, url) => Image.network(
                                      'https://img.freepik.com/free-icon/user_318-159711.jpg',
                                      width: width,
                                      height: height,
                                    ),
                                    errorWidget: (context, url, error) => Image.network(
                                      'https://img.freepik.com/free-icon/user_318-159711.jpg',
                                      width: width,
                                      height: height,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonBoldText(text: applicationBaseController.horoscopeList[index].hname!, fontSize: 14),
                                    commonText(text: 'DOB: ${applicationBaseController.horoscopeList[index].hdobnative!.substring(0, applicationBaseController.horoscopeList[index].hdobnative!.indexOf("T"))}', color: Colors.black38, fontSize: 11)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width:100, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Promise"), buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){
                                  if(applicationBaseController.horoscopeList[index].hstatus == '5'){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => Promises(horoscope: applicationBaseController.horoscopeList[index])));
                                  }else{
                                    CustomDialog.showAlert(context, LocalizationController.getInstance().getTranslatedValue("Promise is yet to be generated"),null, 14);
                                  }
                                })),
                                SizedBox(width:localizationController.currentLanguage.value == 'ta' ? 130 : 100, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Requests"),buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset) async{
                                    if(applicationBaseController.horoscopeList[index].hstatus == '5'){
                                     if(horoscopeRequestController.deviceCurrentLocationFound.value == true){
                                       final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                                       final RelativeRect position = RelativeRect.fromRect(
                                         Rect.fromPoints(
                                           buttonOffset,
                                           buttonOffset + buttonOffset, // buttonSize is the size of the button
                                         ),
                                         Offset.zero & overlay.size, // Overlay size
                                       );
                                       final selectedValue = await showMenu(
                                         context: context,
                                         position: position,
                                         items: [
                                           PopupMenuItem(
                                             value: 1,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Daily Prediction"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 2,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Weekly Prediction"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 3,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Special Prediction"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 4,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Jupiter"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 5,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Saturn"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 6,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Rahu"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 7,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Ketu"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 8,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Mars"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 9,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Sun"), fontSize: 14),
                                           ),
                                           PopupMenuItem(
                                             value: 10,
                                             child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Mercury"), fontSize: 14),
                                           ),
                                         ],
                                       );

                                       if (selectedValue != null) {
                                         switch (selectedValue) {
                                           case 1:
                                             horoscopeRequestController.selectedRequest.value = 1;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => DailyPredictions(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 2:
                                             horoscopeRequestController.selectedRequest.value = 2;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => DailyPredictions(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 3:
                                             horoscopeRequestController.selectedRequest.value = 3;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => const SpecialPredictions()),
                                             );
                                             break;
                                           case 4:
                                             horoscopeRequestController.selectedRequest.value = 4;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 5:
                                             horoscopeRequestController.selectedRequest.value = 5;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 6:
                                             horoscopeRequestController.selectedRequest.value = 6;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 7:
                                             horoscopeRequestController.selectedRequest.value = 7;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 8:
                                             horoscopeRequestController.selectedRequest.value = 8;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 9:
                                             horoscopeRequestController.selectedRequest.value = 9;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                           case 10:
                                             horoscopeRequestController.selectedRequest.value = 10;
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                             );
                                             break;
                                         }
                                       }
                                     }else{
                                       CustomDialog.showLoading(context, 'Please wait');
                                      var request = await horoscopeRequestController.getCurrentLocation(context);
                                      print('the received value of request $request');
                                      if(request == true){
                                        print('the true value is occured');
                                        final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                                        final RelativeRect position = RelativeRect.fromRect(
                                          Rect.fromPoints(
                                            buttonOffset,
                                            buttonOffset + buttonOffset, // buttonSize is the size of the button
                                          ),
                                          Offset.zero & overlay.size, // Overlay size
                                        );
                                        final selectedValue = await showMenu(
                                          context: context,
                                          position: position,
                                          items: [
                                            PopupMenuItem(
                                              value: 1,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Daily Prediction"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Weekly Prediction"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 3,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Special Prediction"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 4,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Jupiter"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 5,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Saturn"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 6,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Rahu"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 7,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Ketu"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 8,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Mars"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 9,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Sun"), fontSize: 14),
                                            ),
                                            PopupMenuItem(
                                              value: 10,
                                              child: commonText(text: LocalizationController.getInstance().getTranslatedValue("Transit of Mercury"), fontSize: 14),
                                            ),
                                          ],
                                        );

                                        if (selectedValue != null) {
                                          switch (selectedValue) {
                                            case 1:
                                              horoscopeRequestController.selectedRequest.value = 1;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => DailyPredictions(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 2:
                                              horoscopeRequestController.selectedRequest.value = 2;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => DailyPredictions(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 3:
                                              horoscopeRequestController.selectedRequest.value = 3;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const SpecialPredictions()),
                                              );
                                              break;
                                            case 4:
                                              horoscopeRequestController.selectedRequest.value = 4;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 5:
                                              horoscopeRequestController.selectedRequest.value = 5;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 6:
                                              horoscopeRequestController.selectedRequest.value = 6;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 7:
                                              horoscopeRequestController.selectedRequest.value = 7;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 8:
                                              horoscopeRequestController.selectedRequest.value = 8;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 9:
                                              horoscopeRequestController.selectedRequest.value = 9;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                            case 10:
                                              horoscopeRequestController.selectedRequest.value = 10;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlanetTransit(horoscope: applicationBaseController.horoscopeList[index])),
                                              );
                                              break;
                                          }
                                        }
                                      }
                                     }
                                    }else{
                                      CustomDialog.showAlert(context, LocalizationController.getInstance().getTranslatedValue("Chart is not rectified yet"),null, 14);
                                    }
                                })),
                                SizedBox(width:localizationController.currentLanguage.value == 'ta' ? 120 : 100, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Charts"),buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)],
                                    onPressed: (Offset buttonOffset) async {
                                      final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                                      final RelativeRect position = RelativeRect.fromRect(
                                        Rect.fromPoints(
                                          buttonOffset,
                                          buttonOffset + buttonOffset, // buttonSize is the size of the button
                                        ),
                                        Offset.zero & overlay.size, // Overlay size
                                      );
                                      final selectedValue = await showMenu(
                                        context: context,
                                        position: position,
                                        items: [
                                          PopupMenuItem(
                                            value: 1,
                                            child: commonText(text: LocalizationController.getInstance().getTranslatedValue('Show Horoscope'), fontSize: 14),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: commonText(text: LocalizationController.getInstance().getTranslatedValue('Edit Horoscope'), fontSize: 14),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: commonText(text: LocalizationController.getInstance().getTranslatedValue('Email Horoscope'), fontSize: 14),
                                          ),
                                          PopupMenuItem(
                                            value: 4,
                                            child: commonText(text: LocalizationController.getInstance().getTranslatedValue('Delete Horoscope'), fontSize: 14),
                                          ),
                                        ],
                                      );

                                      if (selectedValue != null) {
                                        switch (selectedValue) {
                                          case 1:
                                            print('selected value is 1 ${applicationBaseController.horoscopeList[index].hid}');
                                            // Handle Menu 1 option
                                            viewHoroscope(
                                              applicationBaseController.horoscopeList[index].huserid!,
                                              applicationBaseController.horoscopeList[index].hid!.trim(),
                                            );
                                            break;
                                          case 2:
                                            addHoroscopeController.editHoroscope(applicationBaseController.horoscopeList[index]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const AddNativePhoto()),
                                            );
                                            break;
                                          case 3:
                                            print('selected value is 3');
                                            // Handle Menu 3 option
                                            emailHoroscope(
                                              applicationBaseController.horoscopeList[index].huserid!,
                                              applicationBaseController.horoscopeList[index].hid!.trim(),
                                            );
                                            break;
                                          case 4:
                                            print('selected value is 4');
                                            yesOrNoDialog(
                                              context: context,
                                              dialogMessage: 'Are you sure you want to delete this horoscope?',
                                              cancelText: 'No',
                                              okText: 'Yes',
                                              okAction: () {
                                                Navigator.pop(context);
                                                deleteHoroscope(
                                                  applicationBaseController.horoscopeList[index].huserid!,
                                                  applicationBaseController.horoscopeList[index].hid!.trim(),
                                                );
                                              },
                                            );
                                            // Handle Menu 3 option
                                            break;
                                        }
                                      }
                                    }),
                                )],
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
        ),
      );
    });
  }
}
