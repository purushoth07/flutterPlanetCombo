import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:get/get.dart';


class ViewHistory extends StatefulWidget {
  const ViewHistory({Key? key}) : super(key: key);

  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("History"),
        colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route<dynamic> route) => false,
            );
          }, icon: const Icon(Icons.home_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(text: 'headlettersapi@gmail.com', fontSize: 14),
                SizedBox(height: 10),
                commonText(text: '24 juy 2023 : We have the deal', color: Colors.black54, fontSize: 13),
              ],
            ),
          );
        },
      ),
    );
  }
}
