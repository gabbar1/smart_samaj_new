

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/commonWidget/common_snakbar.dart';
import 'package:samaj/screen/tem_part/controller/addController.dart';
import 'package:samaj/screen/tem_part/homeNavigator.dart';


import '../../collections/allCollections.dart';
import '../../commonWidget/commonWidget.dart';
import '../../commonWidget/loader.dart';
import '../dashBoard/dashBoard.dart';

import '../helper/constant.dart';
import '../tem_part/addUserView.dart';
import 'registerPage.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  //AddController addController = Get.find();
  //String phoneNo,verficationId,smsCode,dob,email,password,name, area, pinCode;

  String? phoneNo, verficationId;
  bool codeSent = false;
  bool isLogin=false;
  var isOtp = false.obs;
  bool get getIsOtp => isOtp.value;
  set setIsOtp(bool val){
    isOtp.value = val;
    isOtp.refresh();
  }

  var isChild = false.obs;
  bool get getIsChild => isChild.value;
  set setIsChild(bool val){
    isChild.value = val;
    isChild.refresh();
  }

  Future<void> login({String? phone}) async {
    this.phoneNo = phone!;
    try{
      showLoader();
      verifyPhone("+91 ${phone}");
    }catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      throw e;
    }

  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {};
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {

      Get.snackbar("Error Code 1 : ", authException.message.toString());
    };

    final PhoneCodeSent smsSent = (String? verId, [int? forceResend]) {
      this.codeSent = true;
      this.verficationId = verId!;

      if (codeSent) {
        setIsOtp = true;
        closeLoader();
         Get.to(VerifyOtpScreen());
      } else {
        Get.snackbar("Error", "Code not sent");
      }
      //Fluttertoast.showToast(msg: verficationId.toString());
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verficationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout).then((value) {
      isLogin = true;
    });
  }


  Future<void> loginUser({String? otp,BuildContext? context}) async {
    try{
      showLoader();
      FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verficationId!,
        smsCode: otp!,
        //8160137998
      )).then((value) async{
        closeLoader();
        if(value.additionalUserInfo!.isNewUser) {
          FirebaseFirestore.instance.collection("user_details").where("phone",isEqualTo:  int.parse(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""))).get().then((value) {
            print("==============================");
            print(value.size);
            if(value.size == 0){

              setIsChild = false;
              Get.offAll(AddUserView(isNew: true,));
            }else{
              setIsChild = true;
              Get.offAll(HomeNavigator());
            }
          });

        }
        else{

          Get.offAll(HomeNavigator());

          String? fcm = await FirebaseMessaging.instance.getToken();


          FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).update({
            "fcm_token":fcm
          });


        }
      });
    } on Exception catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      otp=null;
    }
  }


  Future<void> register({UserDetails? addDetails})async{
    showLoader();
    try{

      FirebaseFirestore.instance.collection(Constants().userDetailsCollectionName).doc(addDetails!.phoneNumber).set(  {

        "name" : addDetails.name,
        "email" : addDetails.email,
        "phone_number" : addDetails.phoneNumber,
        "dob" : addDetails.dob,
        "area" : addDetails.area,
        "pincode" : addDetails.pinCode,
        "is_admin" : addDetails.isAdmin,
        "is_parent" : addDetails.isParent,
        "parent_no" : addDetails.phoneNumber,
        "profile":""
      }).then((value) async{
        closeLoader();

        String? fcm = await FirebaseMessaging.instance.getToken();

        FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).update({
          "fcm_token":fcm
        });

        Get.offAll(HomeNavigator());
      });
    }catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      throw e;
    }
  }

}




