import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/register/registerController.dart';

import '../../collections/allCollections.dart';
import '../../commonWidget/commonWidget.dart';
import '../helper/constant.dart';


class RegisterPageView extends StatelessWidget {
  RegisterController registerController = Get.find();
  CommonDatePicker commonDatePicker = Get.put(CommonDatePicker());
  GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        centerTitle: true,
        title: CommonText(text: "Register",fontSize: 20),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Form(
          key: registerFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextInput(
                    hint: "Enter Name",
                    inputController: registerController.nameController,
                    lable: "Name",
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Name",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.emailAddress,
                    hint: "Enter Email",
                    inputController: registerController.emailController,
                    lable: "Email",
                    lableFontSize: 20,
                    isRequired: false,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                regexp: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                errortext: "enter valid email"),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                    textInputType: TextInputType.phone,
                    hint: "Enter Phone",
                    inputController: registerController.phoneController,
                    lable: "Contact Number",
                    lableFontSize: 20,
                    maxLength: 10,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                    regexp: r"^[0-9]{10}$",
                    errortext: "enter valid Number",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.streetAddress,
                  hint: "Enter Area",
                  inputController: registerController.areaController,
                  lable: "Area",
                  lableFontSize: 20,
                  isRequired: false,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Area Name",
                ),

                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.number,
                  hint: "Enter PinCode",
                  inputController: registerController.pincodeController,
                  lable: "Pin Code",
                  lableFontSize: 20,
                  maxLength: 6,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[0-9]{6}$",
                  errortext: "Enter valid PinCode",
                ),
                SizedBox(
                  height: 10,
                ),

                CommonDatePicker()
                    .CommonDateDropdown(text: "DOB", context: context, futureDate: false),
                SizedBox(
                  height: 20,
                ),
               InkWell(
          onTap: (){
            if(registerFormKey.currentState!.validate()){
              print("Validated");
              UserDetails details = new UserDetails();
              details.name = registerController.nameController.text;
              details.email = registerController.emailController.text;
              details.phoneNumber = registerController.phoneController.text;
              details.dob = commonDatePicker.getSelectedDate;
              details.area = registerController.areaController.text;
              details.pinCode = registerController.pincodeController.text;
              details.isAdmin = false;
              details.parentNo = registerController.phoneController.text;
              details.isParent = false;
              registerController.register(addDetails: details,);


            }else{
              print("not validated");
            }
          },
          child: Container(
              width: MediaQuery.of(context!).size.width,
            height:65,
            decoration: BoxDecoration(
              color: Constants().mainColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
                child: CommonText(
                    text: "Register",
                    textColor:  Colors.white,
                    fontStyle: FontWeight.bold,
                    fontSize: 18))),
      ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  validateAndLoad(){

  }
}

class VerifyOtpScreen extends StatelessWidget {
  RegisterController registerController = Get.find();
  String? name,email,phone,dob;
  GlobalKey<FormState> otpFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("OTP screen Module");
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Form(
          key: otpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              CommonTextInput(
                  textInputType: TextInputType.phone,
                  hint: "Enter OTP",
                  inputController: registerController.otpController,
                  lable: "OPT",
                  lableFontSize: 20,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,bottom: 20),
                child: InkWell(
                  onTap: () {
                    if(otpFormKey.currentState!.validate()){
                      print("Validated");
                      registerController.loginUser(context: context,otp: registerController.otpController.text);
                    }else{
                      print("not validated");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width/6.2,
                    decoration: BoxDecoration(
                        color: Constants().mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Center(child: CommonText(text: "Verify", fontStyle: FontWeight.bold,fontSize: 20)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

