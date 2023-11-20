import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../collections/allCollections.dart';
import '../../commonWidget/commonWidget.dart';
import '../helper/constant.dart';
import '../register/registerController.dart';
import '../register/registerPage.dart';

class StartPage extends StatelessWidget {
  RegisterController registerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                CommonText(
                    text: "Welcome",
                    textColor: Colors.black,
                    fontStyle: FontWeight.bold,
                    fontSize: 24),
                CommonText(
                    text: " Back",
                    textColor:  Constants().mainColor,
                    fontStyle: FontWeight.bold,
                    fontSize: 24),
              ],
            ),
          ),
          CommonTextInput(
            textInputType: TextInputType.phone,
            hint: "Enter Phone",
            inputController: registerController.phoneController,
            //lable: "Contact Number",
            lableFontSize: 20,
            maxLength: 10,
            lableFontStyle: FontWeight.bold,
            lableTextColor: Constants().mainColor,
            regexp: r"^[0-9]{10}$",
            errortext: "enter valid Number",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: InkWell(
              onTap: () {
                UserDetails details = new UserDetails();
                details.phoneNumber = registerController.phoneController.text;
                registerController.login(phone:registerController.phoneController.text );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/6.2,
                decoration: BoxDecoration(
                    color: Constants().mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Center(child: CommonText(text: "Login", fontStyle: FontWeight.bold,fontSize: 20)),
              ),
            ),
          ),
          SizedBox(height: 30,)

        ],
      ),
    );
  }
}
