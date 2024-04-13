import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

// String appMode = 'Light';
String appMode = 'Dark';

void showSuccessToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget fullIconColorButton(
    {required String title,
      required Color textColor,
      required Color buttonColor,
      Color? iconColor,
      required BuildContext context,
      required VoidCallback onPressed,
      String? iconUrl}) {
  return SizedBox(
    height: 45,
    width: MediaQuery.of(context).size.width * 1,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(iconUrl, color: iconColor,),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),

    ),
  );
}

Widget fullIconCurveColorButton(
    {required String title,
      required Color textColor,
      required Color buttonColor,
      Color? iconColor,
      required BuildContext context,
      required VoidCallback onPressed,
      String? iconUrl,
      IconData? materialIcon,
      double? materialIconSize
    }) {
  return SizedBox(
    height: 45,
    width: MediaQuery.of(context).size.width * 1,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        elevation: MaterialStateProperty.all(4),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconUrl != null ? SvgPicture.asset(iconUrl, color: iconColor,):
          Icon(materialIcon, size: materialIconSize ?? 16),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),

    ),
  );
}

class GradientButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Function(Offset) onPressed;
  final IconData? materialIcon;
  final List<Color> buttonColors;
  final Color? iconColor;
  final double? materialIconSize;
  final double? buttonHeight;

  GradientButton({super.key, this.buttonHeight,  required this.buttonColors,this.iconColor, this.materialIconSize, required this.title,required this.textColor, required this.onPressed, this.materialIcon});

  final GlobalKey _buttonPositionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: _buttonPositionKey,
      onPressed: () {
        RenderBox? renderBox = _buttonPositionKey.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          Offset offset = renderBox.localToGlobal(Offset.zero);
          onPressed(offset);
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(4),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
        elevation: MaterialStateProperty.all<double>(0),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 12),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        minimumSize: MaterialStateProperty.all<Size>(const Size(0, 48)),
      ),
      child: Ink(
        height: buttonHeight ?? 40,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            colors: buttonColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (materialIcon != null)
              Row(
                children: [
                  const SizedBox(width: 5),
                  Icon(
                    materialIcon,
                    color: iconColor ?? Colors.white,
                    size: materialIconSize ?? 16,
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 12, 0),
              child: commonBoldText(text: title, color: textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

Widget fullIconGradientCurveColorButton(
    {required String title,
      required Color textColor,
      required List<Color> buttonColors,
      Color? iconColor,
      double? buttonHeight,
      required BuildContext context,
      required VoidCallback onPressed,
      String? iconUrl,
      IconData? materialIcon,
      double? materialIconSize,
      void Function(TapUpDetails)? tapUp,
    }) {
  return Container(
    height: buttonHeight ?? 45,
    width: double.infinity,
    decoration:  BoxDecoration(
      borderRadius: BorderRadius.circular(21),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3),
        ),
      ],
      gradient: LinearGradient(
        colors: buttonColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: GestureDetector(
      onTap: onPressed,
      onTapUp: tapUp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconUrl != null ? SvgPicture.asset(iconUrl, color: iconColor,):
          materialIcon == null ? const SizedBox(width: 0):Icon(materialIcon, size: materialIconSize ?? 16, color: Colors.white,),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),

    ),
  );
}

void showFailedToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class CustomDialog{
  static void showLoading(BuildContext context, String title) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12,),
            Text(
              title,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: true,
    ).show();
  }
  static void cancelLoading(BuildContext context) {
    AwesomeDialog(context: context).dismiss();
  }

  static void cancelNoContextLoading() {
    Get.back();
  }

  static void showAlert(
      BuildContext context, String dialogMessage, bool? success, double? fontSize) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                success != null ? Icon(
                  success ? Icons.check_circle : Icons.clear,
                  color: success ? Colors.green : Colors.red,
                  size: 40,
                ):Container(),
                const SizedBox(height: 15),
                Text(
                  dialogMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                      fontSize: fontSize ?? 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            actions: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: TextButton(
                  child: Text(
                      'OK',
                      style: GoogleFonts.lexend(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  onPressed: () {
                    Navigator.pop(context);//Close Dialog Box
                  },
                ),
              ),
            ],
          );
        });
  }

  static void okActionAlert(
      BuildContext context, String dialogMessage,String? okText, bool success, double? fontSize, VoidCallback okAction) {
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){},
              child: AlertDialog(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      success ? Icons.check_circle : Icons.clear,
                      color: success ? Colors.green : Colors.red,
                      size: 40,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      dialogMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                          fontSize: fontSize ?? 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
                actions: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: TextButton(
                      onPressed: okAction ,
                      child: Text(
                          okText?? 'OK',
                          style: GoogleFonts.lexend(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                  ),
                ],
              )
          );
        });
  }
}

Widget commonBoldText({required String text,TextAlign? textAlign, int? maxLines, TextOverflow? textOverflow, Color? color, double? fontSize}){
  return Text(text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: GoogleFonts.lexend(
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w500,
        color: color ?? (appMode == 'Dark' ? Colors.black : Colors.white),
      )
  );
}

Widget gradientContainer({required double height, required BuildContext context, required Widget child}){
  return Container(
    height: height,
    width: MediaQuery.of(context).size.width * 1,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF543eb3),
          Color(0xFFa468ca),
        ],
      ),
    ),
    child: child,
  );
}

Widget commonText({required String text,TextAlign? textAlign,TextDecoration? textDecoration, int? maxLines, TextOverflow? textOverflow, Color? color, double? fontSize}){
  return Text(text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: GoogleFonts.lexend(
        decoration:textDecoration,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w400,
        color: color ?? (appMode == 'Dark' ? Colors.black : Colors.white),
      )
  );
}

class PrimaryInputText extends StatelessWidget {
  final String hintText;
  final String? Function(String? value) onValidate;
  final String? Function(String? value)? onChange;
  final TextEditingController? controller;
  final bool isEnabled;
  final int maxLines;
  final int? maxLength;
  final Widget? suffixImage;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final String? value;
  const PrimaryInputText({Key? key,this.obscureText,this.value, required this.hintText,this.readOnly, this.controller, required this.onValidate,this.isEnabled = true, this.textInputType = TextInputType.text, this.maxLines=1,this.maxLength, this.onChange, this.suffixImage, this.focusNode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: readOnly ?? false,
      style: GoogleFonts.lexend(color: Colors.black),
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      validator: onValidate,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: isEnabled,
      onChanged: onChange,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        counterText: "",
        labelText: hintText,
        suffixIcon: suffixImage,
        labelStyle: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60)
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class PrimaryIconInputText extends StatelessWidget {
  final String hintText;
  final String? Function(String? value) onValidate;
  final String? Function(String? value)? onChange;
  final TextEditingController? controller;
  final bool isEnabled;
  final int maxLines;
  final int? maxLength;
  final Widget? suffixImage;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final String? value;
  const PrimaryIconInputText({Key? key,this.obscureText,this.value, required this.hintText,this.readOnly, this.controller, required this.onValidate,this.isEnabled = true, this.textInputType = TextInputType.text, this.maxLines=1,this.maxLength, this.onChange, this.suffixImage, this.focusNode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: readOnly ?? false,
      style: GoogleFonts.lexend(color: Colors.black),
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      validator: onValidate,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: isEnabled,
      onChanged: onChange,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        counterText: "",
        labelText: hintText,
        suffixIcon: suffixImage,
        labelStyle: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


class PrimaryStraightInputText extends StatelessWidget {
  final String hintText;
  final String? Function(String? value) onValidate;
  final String? Function(String? value)? onChange;
  final TextEditingController? controller;
  final bool isEnabled;
  final int maxLines;
  final int? maxLength;
  final Widget? suffixImage;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final String? value;
  final double? fontSize;
  final double? height;
  const PrimaryStraightInputText({Key? key,this.obscureText,this.fontSize, this.value,this.height, required this.hintText,this.readOnly, this.controller, required this.onValidate,this.isEnabled = true, this.textInputType = TextInputType.text, this.maxLines=1,this.maxLength, this.onChange, this.suffixImage, this.focusNode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 30,
      child: TextFormField(
        initialValue: value,
        readOnly: readOnly ?? false,
        style: GoogleFonts.lexend(color: Colors.black, fontSize: fontSize ?? 14),
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        validator: onValidate,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: isEnabled,
        onChanged: onChange,
        keyboardType: textInputType,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange)
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.lexend(
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w400,
              color: (appMode == 'Dark' ? Colors.black54 : Colors.white60)
          ),
        ),
      ),
    );
  }
}

class PrimaryStraightIconInputText extends StatelessWidget {
  final String hintText;
  final String? Function(String? value) onValidate;
  final String? Function(String? value)? onChange;
  final TextEditingController? controller;
  final bool isEnabled;
  final int maxLines;
  final int? maxLength;
  final Widget? suffixImage;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? obscureText;
  final String? value;
  const PrimaryStraightIconInputText({Key? key,this.obscureText,this.value, required this.hintText,this.readOnly, this.controller, required this.onValidate,this.isEnabled = true, this.textInputType = TextInputType.text, this.maxLines=1,this.maxLength, this.onChange, this.suffixImage, this.focusNode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: readOnly ?? false,
      style: GoogleFonts.lexend(color: Colors.black),
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      validator: onValidate,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: isEnabled,
      onChanged: onChange,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        counterText: "",
        labelText: hintText,
        suffixIcon: suffixImage,
        labelStyle: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: (appMode == 'Dark' ? Colors.black54 : Colors.white60),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


class ReusableDropdown extends StatelessWidget {
  final List<String> options;
  final String currentValue;
  final Function(String?) onChanged;

  ReusableDropdown({required this.options, required this.currentValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: DropdownButton<String>(
        value: currentValue,
        onChanged: onChanged,
        iconEnabledColor: Colors.deepOrange,
        isExpanded: true,
        underline: Container(
          height: 1,
          color: Colors.orange,
        ),
        items: options
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Colors.black54
              )
          ),
        ))
            .toList(),
      ),
    );
  }
}

class ReusableBorderDropdown extends StatelessWidget {
  final List<String> options;
  final String currentValue;
  final Function(String?) onChanged;

  ReusableBorderDropdown({required this.options, required this.currentValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12)
      ),
      height: 45,
      width: double.infinity,
      child: DropdownButton<String>(
        value: currentValue,
        onChanged: onChanged,
        iconEnabledColor: Colors.black,
        isExpanded: true,
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        items: options
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: GoogleFonts.lexend(
                  fontSize: 16,
                  color: Colors.black54
              )
          ),
        ))
            .toList(),
      ),
    );
  }
}

class ReusablePopupButton extends StatelessWidget {
  final List<String> options;
  final Function(String)? onOptionSelected;

  const ReusablePopupButton({super.key,
    required this.options,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return options.map((String option) {
            return PopupMenuItem<String>(
              value: option,
              child: commonBoldText(text: option),
            );
          }).toList();
        },
        onSelected: (String selectedOption) {
          onOptionSelected?.call(selectedOption);
        },
      ),
    );
  }
}


Widget underLineTextButton({required VoidCallback onPressed,TextAlign? textAlign, required String text, Color? color, double? size}){
  return GestureDetector(
    onTap: onPressed,
    child: Text(text,
        textAlign: textAlign,
        style: GoogleFonts.lexend(
          decoration: TextDecoration.underline,
          fontSize: size ?? 14,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
        )),
  );
}

///This is the widget for creating buttons
Widget commonSmallColorButton(
    {required String title,
      required Color textColor,
      double? fontSize,
      required Color buttonColor,
      required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 0, horizontal: 2)),
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // side: const BorderSide(color: Color(0xff979797)),
            borderRadius: BorderRadius.circular(16)))),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Text(
        title,
        style: GoogleFonts.lexend(
          fontSize: fontSize ?? 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}


///This is the widget for creating buttons
Widget commonColorButton(
    {required String title,
      required Color textColor,
      double? fontSize,
      required Color buttonColor,
      required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // side: const BorderSide(color: Color(0xff979797)),
            borderRadius: BorderRadius.circular(4)))),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        title,
        style: GoogleFonts.lexend(
          fontSize: fontSize ?? 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget fullLeftIconColorButton(
    {required String title,
      required Color textColor,
      required Color buttonColor,
      Color? iconColor,
      required BuildContext context,
      required VoidCallback onPressed,
      required String iconUrl}) {
  return SizedBox(
    height: 45,
    width: MediaQuery.of(context).size.width * 1,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        elevation: MaterialStateProperty.all(4),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 40, child: SvgPicture.asset(iconUrl, color: iconColor)),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(
            width: 40,
            child: Opacity(opacity: 0,
            child: SvgPicture.asset(iconUrl, color: iconColor)),
          ),
        ],

      ),

    ),
  );
}

Widget reusablePopUp({required BuildContext context}){
  return GestureDetector(
    onTapUp: (TapUpDetails details) async {
      final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          details.globalPosition,
          details.globalPosition,
        ),
        Offset.zero & overlay.size,
      );

      // Show the popup menu
      final selectedValue = await showMenu(
        context: context,
        position: position,
        items: [
          PopupMenuItem(
            child: Text('Menu 1'),
            value: 1,
          ),
          PopupMenuItem(
            child: Text('Menu 2'),
            value: 2,
          ),
          PopupMenuItem(
            child: Text('Menu 3'),
            value: 3,
          ),
        ],
      );

      // Handle the selected menu option
      if (selectedValue != null) {
        switch (selectedValue) {
          case 1:
          // Handle Menu 1 option
            break;
          case 2:
          // Handle Menu 2 option
            break;
          case 3:
          // Handle Menu 3 option
            break;
        }
      }
    },
  );
}

class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final String? Function(String? value)? onChange;
  final TextEditingController? searchController;
  final FocusNode? focusNode;
  const CommonSearchBar({Key? key, this.focusNode, required this.hintText, this.onChange, this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      focusNode: focusNode,
      showCursor: true,
      controller: searchController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffD6D6D6),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
          color: Color(0xff858585),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xffADADAD),
        ),
      ),
    );
  }
}

Future yesOrNoDialog({required BuildContext context, required String dialogMessage, required String cancelText, required String okText, required VoidCallback okAction}) {
  return  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info,
                color: Colors.red,
                size: 40,
              ),
              const SizedBox(height: 15),
              Text(
                dialogMessage,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
          actionsPadding: EdgeInsets.only(bottom: 8, right: 8),
          actions: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: TextButton(
                child: Text(cancelText,
                    style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);//Close Dialog Box
                },
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red)),
              child: TextButton(
                onPressed: okAction,
                child: Text(okText,
                    style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.red)),
              ),
            ),
          ],
        );
      });
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Color> colors;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  Color? fontColor;

  GradientAppBar({required this.title,this.fontColor, required this.colors , this.leading, this.actions, required this.centerTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        title: commonBoldText(text: title, color: fontColor ?? Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

