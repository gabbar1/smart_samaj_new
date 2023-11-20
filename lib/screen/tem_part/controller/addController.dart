import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/helper/constant.dart';
import 'package:samaj/screen/register/registerController.dart';
import 'package:samaj/screen/tem_part/homeNavigator.dart';
import 'package:samaj/screen/tem_part/model/addModel.dart';
import '../../../commonWidget/commonWidget.dart';
import '../../../commonWidget/loader.dart';



class AddController extends GetxController {
  TextEditingController fistNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController areaNumberController = TextEditingController();
  TextEditingController landmarkNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController maritalController = TextEditingController();
  TextEditingController gotraController = TextEditingController();
  TextEditingController achievementController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  String parentId = "";
  bool hasChild = false;

  bool isShowlistRunning = false;
  RegisterController registerController = Get.find();

  var loadDataStatus = 0.obs;
  int get getLoadDataStatus => loadDataStatus.value;
  set setLoadDataStatus(int val){
    loadDataStatus.value = val;
    notifyChildrens();
  }
  submitData(bool isNew) {
    showLoader(loaderColor: Constants().mainColor);
    UserDetailModel _userDetailModel = UserDetailModel(
        achievements: achievementController.text,
        area: areaNumberController.text,
        blood: bloodController.text,
        city: cityController.text,
        dob: dobController.text,
        email: emailController.text,
        fistName: fistNameController.text,
        gender: genderController.text,
        gotra: gotraController.text,
        houseNo: houseNumberController.text,
        landmark: landmarkNumberController.text,
        lastName: lastNameController.text,
        matital: maritalController.text,
        phone: int.parse(phoneController.text),
        pincode: int.parse(pincodeController.text),
        country: countryController.text,
        profession: professionController.text,
        school: schoolController.text,
        state: stateController.text,
        middleName: middleNameController.text,
        relation:relationController.text,
        userPhone: FirebaseAuth.instance.currentUser!.phoneNumber
            !.replaceAll("+91", ""));
    try {
      FirebaseFirestore.instance.collection("user_details").where("phone",isEqualTo: int.parse(phoneController.text)).get().then((value) {
        if(value.size ==0){
          FirebaseFirestore.instance
              .collection("user_details")
              .add(_userDetailModel.toJson())
              .then((value) {
            closeLoader();
            if(isNew == true){
              Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => HomeNavigator(),), (route) => false);
            }
            else{
              _userDetailModel.id = value.id;
              setUserList(_userDetailModel);
              Navigator.pop(Get.context!);
            }
            Get.snackbar("Info", "Details added.",
                backgroundColor: Constants().snackBackground,
                colorText: Constants().snackFont,
                snackPosition: SnackPosition.BOTTOM);
          });
        }
        else{
          closeLoader();
          Get.snackbar("Alert", "User Already Exist");
        }
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
      closeLoader();
      throw e;
    }
  }

  updateData(String collectionId) {
    try {
      showLoader(loaderColor: Constants().mainColor);
      UserDetailModel _userDetailModel = UserDetailModel(
          achievements: achievementController.text,
          area: areaNumberController.text,
          blood: bloodController.text,
          city: cityController.text,
          dob: dobController.text,
          email: emailController.text,
          fistName: fistNameController.text,
          gender: genderController.text,
          gotra: gotraController.text,
          houseNo: houseNumberController.text,
          landmark: landmarkNumberController.text,
          lastName: lastNameController.text,
          matital: maritalController.text,
          phone: int.parse(phoneController.text),
          pincode: int.parse(pincodeController.text),
          country: countryController.text,
          profession: professionController.text,
          school: schoolController.text,
          state: stateController.text,
          middleName: middleNameController.text,
          relation:relationController.text,
          userPhone: userPhoneController.text);
      FirebaseFirestore.instance
          .collection("user_details")
          .doc(collectionId)
          .update(_userDetailModel.toJson())
          .then((value) {

        userList.value.removeWhere((element) => element.id == collectionId);

        _userDetailModel.id = collectionId!;
        print("========_userDetailModel==");
        print(collectionId);
        print(_userDetailModel.id);
        print(_userDetailModel.toJson());
        userList.value.add(_userDetailModel);
        userList.refresh();
        userList.sort((a,b) {
          if (a.phone == int.parse(b.userPhone!))
            return 0;
          else return 1;

        });
       // setUserList(_userDetailModel);
        closeLoader();
        Navigator.pop(Get.context!);
        Get.snackbar("Info", "Details updated.",
            backgroundColor: Constants().snackBackground,
            colorText: Constants().snackFont,
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
      closeLoader();
      throw e;
    }
  }

  DeleteData(String collectionId) {
    if (phoneController.text == FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")) {
      showDialog<void>(
        context: Get.context!,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return commonAlertBox(
              textColor: Constants().snackFont,
              context: context,
              textMessage1: "Can not Remove your own details.",
              title: "Err");
        },
      );
    } else {
      try {
        FirebaseFirestore.instance
            .collection("user_details")
            .doc(collectionId)
            .delete()
            .then((value) {
          userList.value.removeWhere((element) => element.id == collectionId);
          userList.refresh();
          userList.sort((a,b) {
            if (a.phone == int.parse(b.userPhone!))
              return 0;
            else return 1;

          });
          Navigator.pop(Get.context!);
          Get.snackbar("Info", "Details Deleted.",
              backgroundColor: Constants().snackBackground,
              colorText: Constants().snackFont,
              snackPosition: SnackPosition.BOTTOM);
        });
      } catch (e) {
        Get.snackbar("Error", e.toString());
        showUserList(registerController.getIsChild);
        closeLoader();
        throw e;
      }
    }
  }

  var userList = <UserDetailModel>[].obs;

  List<UserDetailModel> get getUserList => userList.value;

  setUserList(UserDetailModel val) {
    print("---------------------------Adding user list-------------------------");
    if(getUserList.where((element) => element.phone == val.phone).isEmpty){
      userList.value.add(val);
      userList.refresh();
      userList.sort((a,b) {
        if (a.phone == int.parse(b.userPhone!))
          return 0;
        else return 1;

      });
    }else{
      userList.value.remove(val);
      userList.refresh();
    }

  }

  var startAfter;

  void showUserList(bool isChild) {

    try{
      userList.value.clear();

      FirebaseFirestore.instance.collection("user_details").where("phone",isEqualTo:int.parse(FirebaseAuth.instance.currentUser!.phoneNumber
      !.replaceAll("+91", "")) ).get().then((value) {
        UserDetailModel userDetailModel  =UserDetailModel.fromJson(value.docs.first.data(), value.docs.first.id);
        FirebaseFirestore.instance.collection("user_details").where("userPhone",
            isEqualTo: userDetailModel.userPhone)
            .get().then((value) {
          if(value.size == 0){
            setLoadDataStatus = 1;
          }else{
            setLoadDataStatus = 2;
          }
          value.docs.forEach((element) {
            UserDetailModel _userData = UserDetailModel.fromJson(element.data(), element.id);
            setUserList(_userData);
          });
        });
      });
    }catch (e){
      setLoadDataStatus = 3;
      throw e;
    }



  }
}
