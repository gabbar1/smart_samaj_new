import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/dashBoard/model/addModel.dart';

class CurrentUserDetails extends GetxController{

 var currentUser =  UserDetailModel().obs;
 UserDetailModel get getCurrentUser => currentUser.value;
 set setCurrentUser(UserDetailModel val){
   currentUser.value = val;
   currentUser.refresh();
 }

 fetChCurrentUser(){
   try{
     int phone = int.parse(FirebaseAuth.instance.currentUser!.phoneNumber.toString().replaceAll("+91", ""));
     FirebaseFirestore.instance.collection("user_details").where("phone",isEqualTo: phone).get().then((value) {
       print("=========value.size=========");
       print(value.size);
       if(value.size!=0){
         UserDetailModel userDetailModel = UserDetailModel.fromJson(value.docs.first.data());
         setCurrentUser = userDetailModel;
       }
     });
   }catch(e){
     throw e;
   }
 }
}