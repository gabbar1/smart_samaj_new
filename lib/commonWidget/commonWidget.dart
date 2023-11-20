import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samaj/screen/tem_part/controller/user_detail.dart';

import '../screen/helper/constant.dart';
import '../screen/startPage/startPage.dart';
import '../screen/tem_part/controller/family_group_controller.dart';
import '../screen/tem_part/family_group_list.dart';


Widget CommonText(
    {String? text,
    double fontSize = 14.00,
    Color textColor = Colors.white,
    FontWeight fontStyle = FontWeight.normal,
    TextDecoration textDecoration = TextDecoration.none
    }) {
  return Text(
    text!,
    textAlign: TextAlign.center,
    style:
        TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle, decoration: textDecoration,),
  );
}


Widget commonAlertBox(
    {BuildContext? context,
      String textMessage1 = '',
      String textMessage2 = '',
      String title = '',
      double fontSize = 14.00,
      Color textColor = Colors.red,
      FontWeight fontStyle = FontWeight.normal}) {
  return  AlertDialog(
    backgroundColor: Constants().mainColor,
    title: CommonText(text:title,textColor:  textColor),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          CommonText(text: textMessage1,),
          CommonText(text: textMessage2),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: CommonText(text:'Ok', textColor: textColor),
        onPressed: () {
          Navigator.of(context!).pop();
        },
      ),
    ],
  );
}

Widget CommonTextInput(
    {String lable = "",
    hint = "Enter Value",
    FontWeight? lableFontStyle,
    double? lableFontSize,
    lableTextColor,
    int  maxLength = 50,
    TextEditingController? inputController,TextInputType textInputType= TextInputType.text,String regexp = "",errortext,bool isRequired=true,isEnabled=true,TextInputAction textInputAction = TextInputAction.done}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextFormField(
      textCapitalization: TextCapitalization.words,
      enabled: isEnabled,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: inputController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        counterText: "",
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        ),

        isDense: true,                      // Added this
        contentPadding: EdgeInsets.all(25),
        ),
      validator: (value) {
        if (value.toString().isEmpty && isRequired) {
        return 'field required';
        //"Please enter valid floor number";
      }

    },
        ),
  );
}

class CommonDatePicker extends GetxController {
  var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  String get getSelectedDate => selectedDate.value;

  setSelectedDate(String date) {
    selectedDate.value = date;
  }

  CommonDateDropdown(
      {String? text, bool futureDate = true, BuildContext? context}) {
    DateTime selectedStartDate = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonText(
              text: text,
              fontSize: 20,
              textColor: Constants().mainColor,
              fontStyle: FontWeight.bold),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context!,
                  initialDate: selectedStartDate, // Refer step 1
                  firstDate: futureDate ? DateTime.now() : DateTime(1800),
                  lastDate: futureDate ? DateTime(3500) : DateTime.now(),
                  builder: (BuildContext? context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Constants().mainColor,

                        colorScheme:
                            ColorScheme.light(primary: Constants().mainColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  });
              print("---------------PickedDate------------------");
              print(picked);
              if (picked != null && picked != selectedStartDate) {
                selectedStartDate = picked;
                print(selectedStartDate);
              }

              // strStartDate = formatter.format(selectedStartDate);
              selectedDate(formatter.format(selectedStartDate));
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 15, right: 10, top: 11, bottom: 11),
              width: MediaQuery.of(context!).size.width,
              height: MediaQuery.of(context!).size.height / 15,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => CommonText(
                        text: getSelectedDate, textColor: Colors.black87)),
                  ),
                  Icon((Icons.arrow_drop_down))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget CommonButton({
   Function()? onTap,
  BuildContext? context,
  String? buttonText,
  Color? buttonTextColor= Colors.white,
  buttonColor,
  FontWeight? buttonTextStyle = FontWeight.normal,
  double buttonTextSize = 14.00,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        height:65,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: CommonText(
                text: buttonText,
                textColor: buttonTextColor!,
                fontStyle: buttonTextStyle!,
                fontSize: buttonTextSize))),
  );
}


Widget AppDrawer() {
  CurrentUserDetails currentUserDetails = Get.find();
  return Drawer(
    child: Column(
      // Important: Remove any padding from the ListView.

      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Constants().mainColor,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 35,
                child: Icon(Icons.account_circle_outlined),
              ),
              SizedBox(
                width: 10,
              ),
              Obx((){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(text: "${currentUserDetails.getCurrentUser.fistName}  ${currentUserDetails.getCurrentUser.lastName}" ),
                    CommonText(text: currentUserDetails.getCurrentUser.phone.toString()),
                    CommonText(text: currentUserDetails.getCurrentUser.email.toString()),
                  ],
                );
              })
            ],
          ),
        ),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  "assets/icons/about.svg",
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "All Member", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {
            FamilyGroupController familyGroupController = Get.find();
            print(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""));
            if(familyGroupController.getAdminList.contains(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""))){
              Get.to(GroupFamilyList());
            }else{
              Get.snackbar("Alert", "Ask for Admin role",backgroundColor: Constants().mainColor,colorText: Colors.white);
            }

          },
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  "assets/icons/about.svg",
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "What's New", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  "assets/icons/privacy.svg",
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(
                  text: "List of cast members", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.settings,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Job Opportunities", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.settings,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Matrimonial", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.settings,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Networking", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.settings,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Admin Panel", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.logout,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Logout", textColor: Constants().mainColor)
            ],
          ),

          onTap: () {
            FirebaseAuth.instance
                .signOut()
                .whenComplete(() => Get.offAll(StartPage()));
          },

        ),
        Divider(),
        Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                child: CommonText(
                    text: "Version 1.0", textColor: Constants().mainColor),
              ),
            ))
      ],
    ),
  );
}

