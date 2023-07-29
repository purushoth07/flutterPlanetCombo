import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:planetcombo/controllers/applicationbase_controller.dart';
import 'package:planetcombo/controllers/appLoad_controller.dart';
import 'package:planetcombo/controllers/add_horoscope_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  final LocalizationController localizationController =
  Get.put(LocalizationController.getInstance(), permanent: true);

  final AddHoroscopeController addHoroscopeController =
  Get.put(AddHoroscopeController.getInstance(), permanent: true);

  final AppLoadController appLoadController =
  Get.put(AppLoadController.getInstance(), permanent: true);

  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController billingCurrency = TextEditingController();

  void _openImagePicker() {
    print('theis is the images you clciked');
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: commonBoldText(text: 'Choose from Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: commonBoldText(text: 'Take a Photo'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (kDebugMode) {
      print('the picked image is ${pickedImage!.path}');
    }
    addHoroscopeController.setEditImageFileListFromFile(pickedImage);
  }

  bool isSwitched = false;
  
 currentValue(String value){
    if(value == 'ta'){
      return 'தமிழ்';
    }else if(value == 'en'){
      return 'English';
    }else if(value == 'hi'){
      return 'हिंदी';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    addHoroscopeController.editImageFileList = <XFile>[].obs;
    username.text = appLoadController.loggedUserData.value.username!;
    userEmail.text = appLoadController.loggedUserData.value.useremail!;
    billingCurrency.text = appLoadController.loggedUserData.value.ucurrency!;
    if(appLoadController.loggedUserData.value.touchid == 'F'){
      isSwitched = false;
    }else{
      isSwitched = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("Update Profile"),
        colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            addHoroscopeController.editImageFileList!.isNotEmpty ?
            GestureDetector(
              onTap: _openImagePicker,
              child: Container(
                  height:90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: appLoadController.appMidColor,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child:
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.file(File(addHoroscopeController.editImageFileList![0].path),
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
            ):
            GestureDetector(
              onTap: _openImagePicker,
              child: (appLoadController.loggedUserData.value.userphoto == '' || appLoadController.loggedUserData.value.userphoto == null) ?
              Container(
                height:80,
                width: 80,
                decoration: BoxDecoration(
                    color: appLoadController.appMidColor,
                    borderRadius: BorderRadius.circular(50)
                ),
                child:
                Center(child: commonBoldText(text: 'Press here to take your photo',textAlign: TextAlign.center, color: Colors.white, fontSize: 10)),
              ) :
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.network(appLoadController.loggedUserData.value.userphoto!,
                    width: 95, height: 95,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: commonText(textAlign: TextAlign.center,color: Colors.black38, fontSize: 14, text: LocalizationController.getInstance().getTranslatedValue('upload profile picture')),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('User Name'), fontSize: 12, color: addHoroscopeController.horoscopeNameAlert.value == true ? Colors.red : Colors.black87, textAlign: TextAlign.start),
                  PrimaryStraightInputText(
                    onValidate: (v) {
                      if (v == null || v.isEmpty) {
                        addHoroscopeController.horoscopeNameAlert.value = true;
                      }else{
                        addHoroscopeController.horoscopeNameAlert.value = false;
                      }
                      return null;
                    },
                    onChange: (v){
                      if (v == null || v.isEmpty) {
                        addHoroscopeController.horoscopeNameAlert.value = true;
                      }else{
                        addHoroscopeController.horoscopeNameAlert.value = false;
                      }
                      return null;
                    },
                    hintText: LocalizationController.getInstance().getTranslatedValue('Name or Nickname'),
                    controller: username
                  ),
                  const SizedBox(height: 15),
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Email'), fontSize: 12, color: addHoroscopeController.horoscopeNameAlert.value == true ? Colors.red : Colors.black87, textAlign: TextAlign.start),
                  PrimaryStraightInputText(
                    readOnly: true,
                    onValidate: (v) {
                      return null;
                    },
                    hintText: LocalizationController.getInstance().getTranslatedValue('Email'),
                    controller: userEmail,
                  ),
                  const SizedBox(height: 20),
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Country'), fontSize: 12, color: Colors.black87, textAlign: TextAlign.start),
                  ReusableDropdown(options: [
                    LocalizationController.getInstance().getTranslatedValue(appLoadController.loggedUserData.value.ucountry!),
                  ], currentValue: appLoadController.loggedUserData.value.ucountry!, onChanged: (value){
                  }),
                  const SizedBox(height: 10),
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Billing Currency'), fontSize: 12, color: addHoroscopeController.horoscopeNameAlert.value == true ? Colors.red : Colors.black87, textAlign: TextAlign.start),
                  PrimaryStraightInputText(
                    readOnly: true,
                    onValidate: (v) {
                      return null;
                    },
                    hintText: LocalizationController.getInstance().getTranslatedValue('Currency'),
                    controller: billingCurrency,
                  ),
                  const SizedBox(height: 20),
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Language'), fontSize: 12, color: Colors.black87, textAlign: TextAlign.start),
                  ReusableDropdown(options: [
                    LocalizationController.getInstance().getTranslatedValue('English'),
                    LocalizationController.getInstance().getTranslatedValue('தமிழ்'),
                    LocalizationController.getInstance().getTranslatedValue('हिंदी')
                  ], currentValue: currentValue(localizationController.currentLanguage.value), onChanged: (value){
                    print('selected value is $value');
                    if(value == 'தமிழ்'){
                      localizationController.currentLanguage.value = 'ta';
                    }else if(value == 'English'){
                      localizationController.currentLanguage.value = 'en';
                    }else if(value == 'हिंदी'){
                      localizationController.currentLanguage.value = 'hi';
                    }
                    localizationController.getLanguage();
                  }),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonBoldText(text: LocalizationController.getInstance().getTranslatedValue('Finger Touch Security'  )),
                  Switch(
                    value: isSwitched,
                    activeColor: Colors.deepOrange,
                    onChanged: (value) {
                      if(value == false){
                        setState(() {
                          isSwitched = false;
                        });
                      }else{
                        setState(() {
                          isSwitched = true;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
addHoroscopeController.updateProfileWithoutImage(context);
                    }),
                  ),
                ],
              ),
            ),
          ],
        )),
      )
    );
  }
}
