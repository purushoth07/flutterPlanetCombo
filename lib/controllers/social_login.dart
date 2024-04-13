import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planetcombo/common/widgets.dart';

class SocialLoginController extends GetxController {
  static SocialLoginController? _instance;

  static SocialLoginController getInstance() {
    _instance ??= SocialLoginController();
    return _instance!;
  }

  Future<void> loginWithFacebook(context) async {
    try {
      // Trigger Facebook login
      final LoginResult result = await FacebookAuth.instance.login();
      CustomDialog.showLoading(context, 'Please wait');
      print('where the result is  ${result.message} and ${result.status} and ${result.accessToken}');
      // Check if login is successful
      if (result.status == LoginStatus.success) {
        // Get access token
        final AccessToken accessToken = result.accessToken!;
        // Use accessToken for Firebase login
        // Example: FirebaseAuth.instance.signInWithCredential(
        //   FacebookAuthProvider.credential(accessToken.token),
        // );
        // Inside your Firebase login function
        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

// Sign in to Firebase using Facebook credentials
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        CustomDialog.cancelLoading(context);
        final User user = userCredential.user!;
        print('the facebook login user is $user');
      } else {
        // Handle login error
        CustomDialog.cancelLoading(context);
        print('Facebook login failed.');
      }
    } catch (e) {
      // Handle other exceptions
      print('failed reach $e');
      print('Exception: $e');
      CustomDialog.cancelLoading(context);
      CustomDialog.showAlert(context, 'Something went wrong please try later', false, 14);
    }
  }

}