import 'package:flutter/material.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:get/get.dart';
import 'package:planetcombo/screens/dashboard.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late List<bool> _expandedList;


  @override
  void initState() {
    super.initState();
    _expandedList = List<bool>.generate(20, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("Payment Records"),
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
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.0,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(text: 'Invoice date : 12/02/05', color: Colors.grey, fontSize: 13),
                    SizedBox(height: 7),
                    commonText(text: 'Requested Amount : & 25', color: Colors.grey, fontSize: 13),
                    SizedBox(height: 7),
                    commonText(text: 'Total Invoice Amount : & 31.15', color: Colors.grey, fontSize: 13),
                    SizedBox(height: 7),
                    commonText(text: 'Paid Status : & 31.15', color: Colors.grey, fontSize: 13),
                  ],
                ),
                collapsedTextColor: Colors.grey,
                textColor: Colors.black,
                collapsedBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                initiallyExpanded: _expandedList[index],
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tincidunt ante, ac euismod urna. Nullam in magna sed tellus lacinia scelerisque. Aenean elementum neque ac semper semper. In hac habitasse platea dictumst. Nam posuere mauris at suscipit pellentesque. Curabitur vitae scelerisque odio. Phasellus ac malesuada purus. Sed sit amet massa tortor. Fusce vel enim in lorem luctus gravida et ac leo. Vivamus a metus at odio vulputate tincidunt ut id orci. Etiam vel nunc in ante elementum dignissim. Donec tincidunt, purus vitae pulvinar tempus, ligula sem cursus enim, nec placerat lectus ligula et arcu. Donec lacinia, quam id viverra gravida, est leo cursus neque, id vulputate metus lacus a elit. Maecenas at rutrum metus. Suspendisse eu risus euismod, congue purus a, blandit ex.',
                    maxLines: _expandedList[index] ? null : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _expandedList[index] = expanded;
                  });
                },
              ),
            ),
          );
        },
      )
    );
  }
}
