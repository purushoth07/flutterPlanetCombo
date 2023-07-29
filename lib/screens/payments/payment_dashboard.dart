import 'package:flutter/material.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:get/get.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:planetcombo/controllers/add_horoscope_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planetcombo/screens/payments/payment.dart';
import 'package:planetcombo/screens/payments/balance.dart';
import 'package:planetcombo/screens/payments/payment_history.dart';

class PaymentDashboard extends StatefulWidget {
  const PaymentDashboard({Key? key}) : super(key: key);

  @override
  _PaymentDashboardState createState() => _PaymentDashboardState();
}

class _PaymentDashboardState extends State<PaymentDashboard> {

  final double width = 32;
  final double height = 32;

  final LocalizationController localizationController =
  Get.put(LocalizationController.getInstance(), permanent: true);

  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  final AddHoroscopeController addHoroscopeController =
  Get.put(AddHoroscopeController.getInstance(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("Payment"),
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
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 260,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Headletters_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      commonBoldText(fontSize: 19, color: Colors.white, text: LocalizationController.getInstance().getTranslatedValue("Welcome to Planet Combo") ),
                      SizedBox(height: 5),
                      commonText(fontSize: 14, color: Colors.white,textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Planetary calculation on charts, Dasas and transits powered by True Astrology software"))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 110,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => const Pay()));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 0, // Specify the thickness of the border
                                  ),
                                ),
                              ),
                              height:125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/pay.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                  SizedBox(height: 12),
                                  commonBoldText(textAlign: TextAlign.center,text: LocalizationController.getInstance().getTranslatedValue("Pay"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                ],
                              )
                          ),
                        ),
                        Container(
                          width: 0.5,
                          height: 130,
                          decoration: BoxDecoration(
                            color: appLoadController.appMidColor
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => const Balance()));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 0.3, // Specify the thickness of the border
                                  ),
                                ),
                              ),
                              height:125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/wallet.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                  const SizedBox(height: 12),
                                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Balance"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PaymentHistory()));
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/payment-record.svg', width: 21,height: 24, color: appLoadController.appPrimaryColor,),
                      const SizedBox(width: 12),
                      commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Payment History"), color: appLoadController.appPrimaryColor, fontSize: 16),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
