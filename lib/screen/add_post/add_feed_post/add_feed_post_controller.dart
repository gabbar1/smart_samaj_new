import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/commonWidget/loader.dart';
import 'package:samaj/screen/tem_part/homeNavigator.dart';

import 'package:uuid/uuid.dart';

class AddFeedPostController extends GetxController{

  var profilePictures = "".obs;
  String get getProfilePictures => profilePictures.value;
  set setProfilePictures(String val){
    profilePictures.value =val;
    profilePictures.refresh();
  }
//postType
  //image = 1
  // text =2
  uploadImagePost() {
    showLoader();
    Reference ref =  FirebaseStorage.instance.ref();
    String fileID = Uuid().v4();
    ref.child("posts").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).putFile(File(getProfilePictures)).then((p0) async{
      final String url = await ref.child("posts").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).getDownloadURL();
      FirebaseFirestore.instance.collection("posts").add(
          {
            "created_by":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""),
            "post_url":url,
            "create_date":Timestamp.now(),
            "post_type":1,
          }
      ).then((value) {
        closeLoader();
        Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomeNavigator()), (Route<dynamic> route) => false);
      });
    }).onError((error, stackTrace) {
      print("=================erorr============");
      print(error);
      closeLoader();
    });
   // StorageReference ref = storageReference.child("yourstorageLocation/");
  }
  uploadTextPost({String? postText,Color? postTextColor,Color? postBgColor,int? font,double? fontSize}) {
    showLoader();
    FirebaseFirestore.instance.collection("posts").add(
        {
          "created_by":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""),
          "create_date":Timestamp.now(),
          "post_type":2,
          "post_text":postText,
          "post_text_color":postTextColor.toString(),
          "post_bg_color":postBgColor.toString(),
          "font":font,
          "font_size":fontSize

        }
    ).then((value) {
      closeLoader();
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomeNavigator()), (Route<dynamic> route) => true);
    }).onError((error, stackTrace) {
  print("=================erorr============");
  print(error);
  closeLoader();
  });
   // StorageReference ref = storageReference.child("yourstorageLocation/");
  }
}