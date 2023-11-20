

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/commonWidget/common_snakbar.dart';


import '../../collections/allCollections.dart';
import '../../commonWidget/commonWidget.dart';
import '../../commonWidget/loader.dart';
import '../dashBoard/dashBoard.dart';
import '../dashBoard/homeNavigator.dart';
import '../helper/constant.dart';
import 'registerPage.dart';

class RegisterInsertController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController gotraController = TextEditingController();
  //String phoneNo,verficationId,smsCode,dob,email,password,name, area, pinCode;

clearText(){
   emailController.clear();
   fNameController.clear();
   mNameController .clear();
   lNameController.clear();
   houseNoController.clear();
   dobController.clear();
   phoneController.clear();
   otpController.clear();
   areaController.clear();
   pincodeController.clear();
   cityController.clear();
   gotraController.clear();
}

  addUser(UserDetailsForm userDetailsForm){
    try{
      showLoader();
      FirebaseFirestore.instance.collection("user_details").add(userDetailsForm.toJson()).then((value) {
        closeLoader();
        clearText();
        fetchUserDetails();
        Navigator.pop(Get.context!);
      });
    }catch(e){
      closeLoader();
      throw e ;
    }

  }

  var userDetailsList = <UserDetailsForm>[].obs;
  List<UserDetailsForm> get getUserDetailsList => userDetailsList.value;
  set setUserDetailsList(UserDetailsForm val){
    userDetailsList.value.add(val);
    userDetailsList.refresh();
  }

  fetchUserDetails(){
    userDetailsList.clear();
    userDetailsList.refresh();

    FirebaseFirestore.instance.collection("user_details").get().then((value) {
      value.docs.forEach((element) {
        UserDetailsForm userDetailsForm = UserDetailsForm.fromJson(element.data());
        userDetailsForm.key = element.id;
        setUserDetailsList = userDetailsForm;
      });
    });
  }

}




