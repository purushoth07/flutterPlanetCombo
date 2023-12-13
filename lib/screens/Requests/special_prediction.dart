import 'package:flutter/material.dart';

import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/request_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SpecialPredictions extends StatefulWidget {
  const SpecialPredictions({Key? key}) : super(key: key);

  @override
  _SpecialPredictionsState createState() => _SpecialPredictionsState();
}

class _SpecialPredictionsState extends State<SpecialPredictions> {

  final HoroscopeRequestController horoscopeRequestController =
  Get.put(HoroscopeRequestController.getInstance(), permanent: true);

  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    currentTime = DateTime.now();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("Special Predictions"),
        colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route<dynamic> route) => false,
            );
          }, icon: const Icon(Icons.home_outlined))
        ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Obx(() => Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Latitude'))),
                  commonBoldText(text: ':  ${horoscopeRequestController.deviceLatitude.toString()}')
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Longitude'))),
                  commonBoldText(text: ':  ${horoscopeRequestController.deviceLongitude.toString()}')
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Local Time'))),
                  commonBoldText(text: ':  ${DateFormat('hh:mm:ss a').format(currentTime)}')
                ],
              ),
              const SizedBox(height: 15),
              commonText(fontSize: 14, color: Colors.black54, text: LocalizationController.getInstance().getTranslatedValue("Please ask two questions in same category (eg Marriage, Health etc)")),
              const SizedBox(height: 15),
              PrimaryInputText(hintText: '', onValidate: (v){
                return null;
              }, maxLines: 6),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: GradientButton(
                          title: LocalizationController.getInstance().getTranslatedValue("Cancel"),buttonHeight: 45, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){
                        Navigator.pop(context);
                      }),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      child: GradientButton(
                          title: LocalizationController.getInstance().getTranslatedValue("Save"),buttonHeight: 45, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){

                      }),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ),
      )
    );
  }
}
