import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:samaj/commonWidget/loader.dart';

import 'model/job_list_model.dart';

class AddJobController extends GetxController{

  TextEditingController  name = TextEditingController();
  TextEditingController  companyName = TextEditingController();
  TextEditingController  experienceController = TextEditingController();
  TextEditingController  designationController = TextEditingController();
  TextEditingController  salaryController = TextEditingController();
  TextEditingController  locationController = TextEditingController();
  TextEditingController  whatsAppController = TextEditingController();
  TextEditingController  descriptionController = TextEditingController();
  var experience = 0.obs;
  int get getExperience => experience.value;
  set setExperience(int val){
    experience.value = val;
    experience.refresh();
  }

  addJobPost(){
    showLoader();
    FirebaseFirestore.instance.collection("job_post").add({
      "job_title":name.text,
      "company_name":companyName.text,
      "experience":experienceController.text,
      "salary":salaryController.text,
      "whatsapp_number":whatsAppController.text,
      "description":designationController.text,
      "create_date":Timestamp.now(),
      "created_by":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""),
      "location":locationController.text,
      "isActive":true
    }).then((value) {
      closeLoader();
      Navigator.pop(Get.context!);
    }).onError((error, stackTrace) {
      closeLoader();
    });
  }
  
  var jobPostList = <JobPostListModel>[].obs;
  List<JobPostListModel> get getJobPostList => jobPostList.value;
  set setJobPostList(JobPostListModel val){
    jobPostList.value.add(val);
    jobPostList.refresh();
  }
  DocumentSnapshot? lastDocument;
  fetchJobPostList(){
    jobPostList.value.clear();
    FirebaseFirestore.instance.collection("job_post").where("isActive",isEqualTo: true).orderBy("created_by",descending: true).limit(10).get().then((value) {
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          lastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          JobPostListModel jobPostListModel = JobPostListModel.fromJson(element.data());
          jobPostListModel.key = element.id;
          setJobPostList = jobPostListModel;
        });
      }
    });
  }
  nextJobPostList(){

    FirebaseFirestore.instance.collection("job_post").where("isActive",isEqualTo: true).orderBy("created_by",descending: true).startAfterDocument(lastDocument!).limit(10).get().then((value) {
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          lastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          JobPostListModel jobPostListModel = JobPostListModel.fromJson(element.data());
          jobPostListModel.key = element.id;
          setJobPostList = jobPostListModel;
        });
      }
    });
  }

  var myJobPostList = <JobPostListModel>[].obs;
  List<JobPostListModel> get getMyJobPostList => myJobPostList.value;
  set setMyJobPostList(JobPostListModel val){
    myJobPostList.value.add(val);
    myJobPostList.refresh();
  }
  DocumentSnapshot? myLastDocument;
  fetchMyJobPostList(){
    myJobPostList.value.clear();
    FirebaseFirestore.instance.collection("job_post").where("created_by",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).limit(20).get().then((value) {
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          myLastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          JobPostListModel jobPostListModel = JobPostListModel.fromJson(element.data());
          jobPostListModel.key = element.id;
          setMyJobPostList = jobPostListModel;
        });
      }
    });
  }
  Future<void> nextMyJobPostList() async{

    FirebaseFirestore.instance.collection("job_post").where("created_by",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).startAfterDocument(myLastDocument!).limit(20).get().then((value) {
      if(value.size!=0){
        if(value.docs.isNotEmpty){
          myLastDocument = value.docs[value.docs.length -1];
        }
        value.docs.forEach((element) {
          JobPostListModel jobPostListModel = JobPostListModel.fromJson(element.data());
          jobPostListModel.key = element.id;
          setMyJobPostList = jobPostListModel;
        });
      }
    });
  }
}