import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/add_post/add_biodata/model/sibling_model.dart';
import 'package:uuid/uuid.dart';

import '../../../commonWidget/loader.dart';
import 'model/matrimonial_list_model.dart';

class AddBioDataController extends GetxController{

  TextEditingController name =TextEditingController();
  TextEditingController lName =TextEditingController();
  TextEditingController gotra =TextEditingController();
  TextEditingController manglik =TextEditingController();
  TextEditingController dob =TextEditingController();
  TextEditingController birthPlace =TextEditingController();
  TextEditingController height =TextEditingController();
  TextEditingController weight =TextEditingController();
  TextEditingController education =TextEditingController();
  TextEditingController hobby =TextEditingController();
  TextEditingController occupation =TextEditingController();
  TextEditingController income =TextEditingController();
  TextEditingController fatherName =TextEditingController();
  TextEditingController fatherOccupation =TextEditingController();
  TextEditingController motherName =TextEditingController();
  TextEditingController motherOccupation =TextEditingController();
  TextEditingController isSibling =TextEditingController();
  TextEditingController gender =TextEditingController();

  var isManglik = false.obs;
  bool get getIsManglik => isManglik.value;
  set setIsManglik(bool val){
    isManglik.value = val;
    isManglik.refresh();
  }

  var isGirl = false.obs;
  bool get getIsGirl => isGirl.value;
  set setIsGirl(bool val){
    isGirl.value = val;
    isGirl.refresh();
  }

  var selectedDate = DateTime.now().obs;
  DateTime get getSelectedDate => selectedDate.value;
  set setSelectedDate(DateTime val){
    selectedDate.value = val;
    selectedDate.refresh();
  }

  var isSiblings = false.obs;
  bool get getIsSiblings => isSiblings.value;
  set setIsSiblings(bool val){
    isSiblings.value = val;
    isSiblings.refresh();
  }

  var siblingList = <SiblingModel>[].obs;
  List<SiblingModel> get getSiblingList => siblingList.value;
  set setSiblingList(SiblingModel val){
    siblingList.value.add(val);
    siblingList.refresh();
  }

  var isYounger=false.obs;
  bool get getIsYounger => isYounger.value;
  set setIsYounger(dynamic val){
    isYounger.value = val;
    isYounger.refresh();
  }

  var isBrother=false.obs;
  bool get getIsBrother => isBrother.value;
  set setIsBrother(dynamic val){
    isBrother.value = val;
    isBrother.refresh();
  }

  var profilePictures = <String>[].obs;
  List<String> get getProfilePictures => profilePictures.value;
  set setProfilePictures(String val){
    profilePictures.value.add(val);
    profilePictures.refresh();
  }

  var isDone = true.obs;
  bool get getIsDone => isDone.value;
  set setIsDone(bool val){
    isDone.value=val;
    isDone.refresh();
  }

  TextEditingController siblingName = TextEditingController();
  TextEditingController siblingOccupation = TextEditingController();
  TextEditingController younger = TextEditingController();
  TextEditingController sister = TextEditingController();

  clear(){
    name.clear();
    lName.clear();
    gotra.clear();
    birthPlace.clear();
    height.clear();
    weight.clear();
    education.clear();
    hobby.clear();
    occupation.clear();
    income.clear();
    fatherName.clear();
    fatherOccupation.clear();
    motherName.clear();
    motherOccupation.clear();
    siblingList.value.clear();
    profilePictures.value.clear();
    profilePicturesUrl.value.clear();
    setIsBrother =false ;
    setIsYounger =false ;
    setIsManglik =false ;
    setIsDone =false ;
    setSelectedDate =DateTime.now() ;


  }
  addBioData(){
    FirebaseFirestore.instance.collection("bio_data").add({
      "image_url":getProfilePicturesUrl.first,
      "name":name.text,
      "last_name":lName.text,
      "gotra":gotra.text,
      "isManglik":getIsManglik,
      "dob":Timestamp.fromDate(getSelectedDate),
      "birth_place":birthPlace.text,
      "height":height.text,
      "weight":weight.text,
      "qualification":education.text,
      "hobbies":hobby.text,
      "occupation":occupation.text,
      "income":income.text,
      "father_name":fatherName.text,
      "father_occupation":fatherOccupation.text,
      "mother_name":motherName.text,
      "mother_occupation":motherOccupation.text,
      "isSibling":getIsSiblings,
      "createdBy":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""),
      "isActive":true,
      "isGirl":getIsGirl,
      "create_date":Timestamp.now()
    }).then((value) {
      if(getSiblingList.length !=0){
        getSiblingList.forEach((element) {
          FirebaseFirestore.instance.collection("bio_data").doc(value.id).collection("siblings").add(element.toJson());
        });
      }
      if(getProfilePicturesUrl.length!=0){
        getProfilePicturesUrl.forEach((element) {
          FirebaseFirestore.instance.collection("bio_data").doc(value.id).collection("candidate_url").add(
              {
                "image":element
              });
        });

      }
      closeLoader();
      clear();
      Navigator.pop(Get.context!);

    }).onError((error, stackTrace) {
      closeLoader();
    });
  }

  var profilePicturesUrl = <String>[].obs;
  List<String> get getProfilePicturesUrl => profilePicturesUrl.value;
  set setProfilePicturesUrl(String val){
    profilePicturesUrl.value.add(val);
    profilePicturesUrl.refresh();
  }

  var operationsCompleted = 0;
   operation() {

     print("=============before------------");
     print(getProfilePictures.length);
     print(operationsCompleted);
    ++operationsCompleted;
     print("=============after------------");
     print(getProfilePictures.length);
     print(operationsCompleted);
    if (operationsCompleted == getProfilePictures.length) addBioData();
  }
  uploadCandidateWidget() async{
     showLoader();
    Reference ref =  FirebaseStorage.instance.ref();

    await Future.forEach(getProfilePictures, (element) async{
      String fileID = Uuid().v1();
      await ref.child("bio_data").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).putFile(File(element)).then((p0) async{
        print("-------------uploaded=============");
        final String url = await ref.child("bio_data").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).getDownloadURL();
        setProfilePicturesUrl = url;
      }).then((value) {
      }).onError((error, stackTrace) {
        print("=================erorr============");
        print(error);
        closeLoader();
      });
    }).then((value) {
      addBioData();
    });
     /*getProfilePictures.forEach((element) async{
      print("=====================uploadImage============");
      print(element);
      await ref.child("bio_data").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).putFile(File(element)).then((p0) async{
        print("-------------uploaded=============");
        final String url = await ref.child("bio_data").child(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).child(fileID).getDownloadURL();
        setProfilePicturesUrl = url;
      }).then((value) {
        operation();
      }).onError((error, stackTrace) {
        print("=================erorr============");
        print(error);
        closeLoader();
      });
    });*/

    // StorageReference ref = storageReference.child("yourstorageLocation/");
  }

  var matrimonialList = <MatrimonialListModel>[].obs;
  List<MatrimonialListModel> get getMatrimonialList => matrimonialList.value;
  set setMatrimonialList(MatrimonialListModel val){
    matrimonialList.value.add(val);
    matrimonialList.refresh();
  }
  DocumentSnapshot? lastDocument;
  fetchMatrimonialList(){
    matrimonialList.value.clear();
     FirebaseFirestore.instance.collection("bio_data").where("isActive",isEqualTo: true).orderBy("create_date",descending: true).limit(10).get().then((value) {
       print("=====================fetchMatrimonialList==================");
       if(value.size!=0){
         if(value.docs.isNotEmpty){
           lastDocument = value.docs[value.docs.length -1];
         }
         value.docs.forEach((element) {
           print( element.data());
           MatrimonialListModel matrimonialListModel = MatrimonialListModel.fromJson(element.data());
           matrimonialListModel.key = element.id;
           setMatrimonialList = matrimonialListModel;
         });
       }
     });
  }
  nextMatrimonialList(){

     FirebaseFirestore.instance.collection("bio_data").where("isActive",isEqualTo: true).orderBy("create_date",descending: true).limit(10).startAfterDocument(lastDocument!).get().then((value) {
       print("=====================fetchMatrimonialList==================");
       if(value.size!=0){
         if(value.docs.isNotEmpty){
           lastDocument = value.docs[value.docs.length -1];
         }
         value.docs.forEach((element) {
           print( element.data());
           MatrimonialListModel matrimonialListModel = MatrimonialListModel.fromJson(element.data());
           matrimonialListModel.key = element.id;
           setMatrimonialList = matrimonialListModel;
         });
       }
     });
  }

  var myMatrimonialList = <MatrimonialListModel>[].obs;
  List<MatrimonialListModel> get getMyMatrimonialList => myMatrimonialList.value;
  set setMyMatrimonialList(MatrimonialListModel val){
    myMatrimonialList.value.add(val);
    myMatrimonialList.refresh();
  }
  DocumentSnapshot? myLastDocument;
  fetchMyMatrimonialList(){
    myMatrimonialList.value.clear();
    FirebaseFirestore.instance.collection("bio_data").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).orderBy("create_date",descending: true).limit(20).get().then((value) {
      print("=====================fetchMatrimonialList==================");
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          myLastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          print( element.data());
          MatrimonialListModel matrimonialListModel = MatrimonialListModel.fromJson(element.data());
          matrimonialListModel.key = element.id;
          setMyMatrimonialList = matrimonialListModel;
        });
      }
    });
  }
  nextMyMatrimonialList(){

    FirebaseFirestore.instance.collection("bio_data").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).orderBy("create_date",descending: true).limit(20).startAfterDocument(myLastDocument!).get().then((value) {
      print("=====================fetchMatrimonialList==================");
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          myLastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          print( element.data());
          MatrimonialListModel matrimonialListModel = MatrimonialListModel.fromJson(element.data());
          matrimonialListModel.key = element.id;
          setMyMatrimonialList = matrimonialListModel;
        });
      }
    });
  }

  var matrimonialSiblingList = <SiblingModel>[].obs;
  List<SiblingModel> get getMatrimonialSiblingList => matrimonialSiblingList.value;
  set setMatrimonialSiblingList(SiblingModel val){
   // print(val.toJson());
    matrimonialSiblingList.value.add(val);
    matrimonialSiblingList.refresh();
    getMatrimonialSiblingList.forEach((element) {
      print(element.toJson());
    });
  }

  var matrimonialProfilePicturesUrl = <String>[].obs;
  List<String> get getMatrimonialProfilePicturesUrl => matrimonialProfilePicturesUrl.value;
  set setMatrimonialProfilePicturesUrl(String val){
    matrimonialProfilePicturesUrl.value.add(val);
    matrimonialProfilePicturesUrl.refresh();
  }
  fetchBioDetails(String key){
    matrimonialProfilePicturesUrl.clear();
    matrimonialProfilePicturesUrl.refresh();
    matrimonialSiblingList.value.clear();
    matrimonialSiblingList.refresh();
   try{
     FirebaseFirestore.instance.collection("bio_data").doc(key).collection("candidate_url").get().then((value) {
       if(value.size!=0){
         value.docs.forEach((element) {
           setMatrimonialProfilePicturesUrl = element.get("image");
         });
       }
     });
   }catch(e){
     throw e;
   }

   try{
     FirebaseFirestore.instance.collection("bio_data").doc(key).collection("siblings").get().then((value) {
       if(value.size!=0){
         value.docs.forEach((element) {
           print("=======================");
           print(element.data());
           setMatrimonialSiblingList = SiblingModel.fromJson(element.data());
         });
       }
     });
   }catch(e){
     throw e;
   }
  }

}