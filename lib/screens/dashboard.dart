import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/add_horoscope_controller.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:planetcombo/screens/find/find_place.dart';
import 'package:planetcombo/screens/messages/message_list.dart';
import 'package:planetcombo/screens/payments/payment_dashboard.dart';
import 'package:planetcombo/screens/policy.dart';
import 'package:planetcombo/screens/predictions/predictions.dart';
import 'package:planetcombo/screens/profile/profile.dart';
import 'package:planetcombo/screens/services/horoscope_services.dart';
import 'package:planetcombo/screens/social_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:planetcombo/screens/live_chat.dart';
import 'package:local_auth/local_auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final LocalAuthentication auth = LocalAuthentication();

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
      appBar:GradientAppBar(
        leading: Obx(() => GestureDetector(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Profile()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: appLoadController.loggedUserData.value.userphoto!,
                width: width,
                height: height,
                fit: BoxFit.cover,
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
          ),
        )),
        actions: [
          PopupMenuButton<String>(
            icon: Image.asset(
              'assets/svg/Language.png',
              width: 32,
              height: 32,
            ),
            itemBuilder: (BuildContext context) {
              return ['தமிழ்', 'English', 'हिंदी'].map((String language) {
                return PopupMenuItem<String>(
                  value: language,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      commonBoldText(text: language),
                    ],
                  ),
                );
              }).toList();
            },
            onSelected: (String language) {
              print('the selected language is $language');
              if(language == 'தமிழ்'){
                localizationController.currentLanguage.value = 'ta';
                addHoroscopeController.addHoroscopeGender.value = 'ஆண்';
              }else if(language == 'English'){
                localizationController.currentLanguage.value = 'en';
                addHoroscopeController.addHoroscopeGender.value = 'Male';
              }else if(language == 'हिंदी'){
                localizationController.currentLanguage.value = 'hi';
                addHoroscopeController.addHoroscopeGender.value = 'पुरुष';
              }
              localizationController.getLanguage();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Dashboard()));
              // Handle language selection
            },
          ),
        ],
        title: LocalizationController.getInstance().getTranslatedValue("Home"),
        colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: 620,
              child: Stack(
                children: [
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
                  Positioned.fill(
                    top: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const HoroscopeServices()));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/Services.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(textAlign: TextAlign.center,text: LocalizationController.getInstance().getTranslatedValue("Horoscope Services"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const Profile()));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/Profile_Update.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          const SizedBox(height: 12),
                                          commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Profile Update"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const MessagesList()));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/Messages.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Messages"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const LiveChat()));
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
                                          SvgPicture.asset('assets/svg/Messages.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Live Chat"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 480,
                              decoration: BoxDecoration(
                                color: appLoadController.appPrimaryColor
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const PaymentDashboard()));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/Services.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(textAlign: TextAlign.center,text: LocalizationController.getInstance().getTranslatedValue("Payment"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const Predictions()));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/prediction.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Predictions"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const FindPlace()));

                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: appLoadController.appPrimaryColor,
                                            width: 0.3, // Specify the thickness of the border
                                          ),
                                        ),
                                      ),
                                      height:125,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/svg/findplace.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Find Place"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const TermsConditions()));
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
                                          SvgPicture.asset('assets/svg/Terms-conditions.svg', width: 52,height: 52, color: appLoadController.appPrimaryColor,),
                                          SizedBox(height: 12),
                                          commonBoldText(textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Terms and Conditions"),fontSize: 13, color: appLoadController.appPrimaryColor)
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: GestureDetector(
                onTap: (){
                  yesOrNoDialog(context: context, dialogMessage: 'Are you sure you want to logout?', cancelText: 'No', okText: 'Yes', okAction: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('UserInfo');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SocialLogin()),
                          (Route<dynamic> route) => false,
                    );
                  });
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
                      SvgPicture.asset('assets/svg/logout.svg', width: 16,height: 16, color: appLoadController.appPrimaryColor,),
                      const SizedBox(width: 12),
                      commonBoldText(text: LocalizationController.getInstance().getTranslatedValue("Logout"), color: appLoadController.appPrimaryColor, fontSize: 16),
                    ],
                  )
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                commonText(textAlign: TextAlign.center, text: '© ${LocalizationController.getInstance().getTranslatedValue("Planet Combo... All rights reserved")}', fontSize: 12),
                const SizedBox(height: 5),
                commonText(textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Developed by Aara Tech Private Limited"), fontSize: 12),
                const SizedBox(height: 5),
                commonText(textAlign: TextAlign.center, text: LocalizationController.getInstance().getTranslatedValue("Version : 1.0.0"), fontSize: 12),
                const SizedBox(height: 12),
              ],
            )
          ],
        ),
      )
    );
  }
}
