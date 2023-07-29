import 'package:flutter/material.dart';
import 'package:planetcombo/api/api_callings.dart';

import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/request_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DailyPredictions extends StatefulWidget {
  const DailyPredictions({Key? key}) : super(key: key);

  @override
  _DailyPredictionsState createState() => _DailyPredictionsState();
}

class _DailyPredictionsState extends State<DailyPredictions> {


  final HoroscopeRequestController horoscopeRequestController =
  Get.put(HoroscopeRequestController.getInstance(), permanent: true);

  DateTime currentTime = DateTime.now();

  DateTime? selectedDate;

  DateTime? endDate;

  DateTime getAfterSevenDays(DateTime inputDate) {
    DateTime afterSevenDays = inputDate.add(const Duration(days: 7));
    return afterSevenDays;
  }

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
        title: horoscopeRequestController.selectedRequest.value == 1 ? LocalizationController.getInstance().getTranslatedValue("Daily Request") : LocalizationController.getInstance().getTranslatedValue("Weekly Request"),
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
      body: Obx(() =>
          Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
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
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Select Date'))),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {},
                          onConfirm: (date) {
                            setState(() {
                              selectedDate = date;
                              endDate = getAfterSevenDays(selectedDate!);
                            });
                          },
                          currentTime: selectedDate ?? DateTime.now(),
                        );
                      },
                      child: commonBoldText(text: selectedDate != null
                          ? ':  ${DateFormat('dd-MM-yy').format(selectedDate!)}'
                          : ':  Select Date'),
                    ),
                    SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down, size: 34, color: Colors.black26,)
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            horoscopeRequestController.selectedRequest.value == 2 ? Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('End Date'))),
                Row(
                  children: [
                    commonBoldText(text: endDate != null
                        ? ':'plkl'  ${DateFormat('dd-MM-yy').format(endDate!)}'
                        : ':  '),
                  ],
                )
              ],
            ): const SizedBox(),
            SizedBox(height: horoscopeRequestController.selectedRequest.value == 2 ? 15 : 0),
            horoscopeRequestController.selectedRequest.value == 1 ? commonText(fontSize: 14, color: Colors.black54, text: LocalizationController.getInstance().getTranslatedValue("Prediction of event is based on the above Latitude and Longitude. If you change timezone there will be difference in prediction")):const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [\SizedBox(]
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
                      var response = APICallings.getDuplicateReq]\\\est(userId: userId, hId: hId, rsqDate: rsqDate, reqDate: reqDate, rqCat: rqCat, token: token)
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ))
    );
  }
}
