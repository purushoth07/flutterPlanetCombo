import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/common/constant.dart';
import 'package:planetcombo/controllers/apiCalling_controllers.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:get/get.dart';
import 'package:planetcombo/controllers/applicationbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:planetcombo/models/social_login.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/api/api_callings.dart';
import 'package:planetcombo/service/local_notification.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  final ApplicationBaseController applicationBaseController =
  Get.put(ApplicationBaseController.getInstance(), permanent: true);

  final ApiCallingsController apiCallingsController =
  Get.put(ApiCallingsController.getInstance(), permanent: true);

  Constants constants = Constants();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut();
    // Attempt to get the currently signed-in user
    GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

    // If there is no user currently signed in, authenticate with Google
    currentUser ??= await _googleSignIn.signIn();

    // Authenticate with Firebase using the Google credential
    final GoogleSignInAuthentication googleAuth =
    await currentUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    NotificationService.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logintn.jpg'),
          fit: BoxFit.cover,
        ),
      ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double maxWidth = 300;
                      double width = constraints.maxWidth < maxWidth
                          ? constraints.maxWidth
                          : maxWidth;
                      return Image.asset(
                        'assets/images/headletters.png',
                        width: width,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  fullLeftIconColorButton(title: 'Continue with google', textColor: Colors.black, buttonColor: Colors.white, context: context,
                      onPressed: () async{
                           CustomDialog.showLoading(context, 'Please wait');
                            final UserCredential userCredential =
                            await signInWithGoogle();
                            print('the value received for google firebase login');
                            print(userCredential);
                            var response = await apiCallingsController.socialLogin(userCredential!.user!.email!, constants.mediumGmail, constants.password, userCredential!.user!.uid!, context);
                            print('the recevied vale of response');
                            // print(response);
                           print(response);
                           CustomDialog.cancelLoading(context);
                            if(response == true){
                              final prefs = await SharedPreferences.getInstance();
                              String? jsonString = prefs.getString('UserInfo');
                              var jsonBody = json.decode(jsonString!);
                              print('we reached $jsonBody');
                              appLoadController.loggedUserData.value = SocialLoginData.fromJson(jsonBody);
                              print('the data of userId is ${appLoadController.loggedUserData.value.userid}');
                              applicationBaseController.initializeApplication();
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => const Dashboard()));
                            }else{
                              CustomDialog.showAlert(context, 'Something went wrong Please try later', false, 16);
                            }
                        }, iconUrl: 'assets/svg/google.svg'),
                  const SizedBox(height: 30),
                  fullLeftIconColorButton(title: 'Login with facebook', textColor: Colors.white,iconColor: Colors.white,  buttonColor: appLoadController.appPrimaryColor, context: context, onPressed: (){
                    NotificationService.showBigTextNotification(title: "New message title", body: "Your long body", fln: flutterLocalNotificationsPlugin);
                  }, iconUrl: 'assets/svg/facebook-logo.svg'),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          )
          //
          // Center(
          //     child: _googleSignIn.currentUser == null ?
          //     TextButton(onPressed: ()async {
          //       try {
          //         final UserCredential userCredential =
          //         await signInWithGoogle();
          //         print('the value received for google firebase login');
          //         print(userCredential);
          //         // Do something with the signed-in user
          //       } catch (e) {
          //         // Handle sign-in errors
          //       }
          //     }, child: Text('Sign in with Google')) :
          //     TextButton(onPressed: (){}, child: Text(_googleSignIn.currentUser!.displayName!))
          // ),
        ),
      );
}}
