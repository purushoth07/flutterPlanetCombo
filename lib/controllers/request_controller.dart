import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:planetcombo/common/widgets.dart';

class HoroscopeRequestController extends GetxController {
  static HoroscopeRequestController? _instance;

  static HoroscopeRequestController getInstance() {
    _instance ??= HoroscopeRequestController();
    return _instance!;
  }

  RxInt selectedRequest = 0.obs;

  RxDouble deviceLatitude = 0.0.obs;
  RxDouble deviceLongitude = 0.0.obs;

  RxBool deviceCurrentLocationFound = false.obs;

  Rx<DateTime> currentTime = DateTime.now().obs;


  Future<bool> getCurrentLocation(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      CustomDialog.cancelLoading(context);
      CustomDialog.showAlert(context, 'Please Turn on Location Service', null, 14);
      return false;
    }

    // Request permission to access the location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission is denied, handle accordingly
        CustomDialog.cancelLoading(context);
        CustomDialog.showAlert(context, 'Location Permission is denied, please approve for future assistance', null, 14);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission is permanently denied, handle accordingly
      CustomDialog.cancelLoading(context);
      CustomDialog.showAlert(context, 'Please enable GPS on your phone Settings', false, 14);
      return false;
    }

    // Get the current position (latitude and longitude)
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    deviceLatitude.value  = position.latitude;
    deviceLongitude.value = position.longitude;

    deviceCurrentLocationFound.value = true;

    // Do something with the latitude and longitude values
    print('Latitude: ${deviceLatitude.value}, Longitude: ${deviceLongitude.value}');
    CustomDialog.cancelLoading(context);
    return true;
  }


}