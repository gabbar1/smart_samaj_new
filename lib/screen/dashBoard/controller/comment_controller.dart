import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/dashBoard/model/addModel.dart';

import '../model/comment_model.dart';

class CommentController extends GetxController{


  var userDetail = UserDetailModel().obs;
  UserDetailModel get getUserDetails => userDetail.value;
  fetchUserDetails() async{
    await FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).get().then((value) {
      userDetail.value.fistName = value.get("name");
      userDetail.value.email = value.get("profile");
      userDetail.refresh();
    });

  }
  var commentList = <CommentModel>[].obs;
  List<CommentModel> get getCommentList =>commentList.value;
  set setCommentList(CommentModel val){
    commentList.value.add(val);
    commentList.refresh();
  }

  var isLoadingList = 0.obs;
  int get getIsLoadingList => isLoadingList.value;
  set setIsLoadingList(int val){
    isLoadingList.value =val;
    isLoadingList.refresh();
  }
  DocumentSnapshot? lastDocument;
  fetchCommentList(String postId,bool isNew){
      commentList.clear();
      commentList.refresh();
    FirebaseFirestore.instance.collection("posts").doc(postId).collection("comments").orderBy("comment_date",descending: true).limit(5).get().then((value) {
      if(value.size!=0){
        lastDocument = value.docs[value.docs.length -1];
        Future.forEach(value.docs, (element) async{
          CommentModel commentModel = CommentModel.fromJson(element.data());
          commentModel.key = element.id;
          await FirebaseFirestore.instance.collection("user_details").doc(commentModel.commentBy).get().then((value) {
            commentModel.userName = value.get("name");
            commentModel.profile = value.get("profile");
          });
          print('==================comment profile==================');
          print(commentModel.toJson());
          setCommentList = commentModel;
        }).then((value) {
          setIsLoadingList= 1;
        });

      }else{
        setIsLoadingList= 2;
      }
    });
  }
  fetchRefreshCommentList(String postId)async{
    FirebaseFirestore.instance.collection("posts").doc(postId).collection("comments").orderBy("comment_date",descending: true).limit(5).startAfterDocument(lastDocument!).get().then((value) {
      if(value.size!=0){
        lastDocument = value.docs[value.docs.length -1];
        Future.forEach(value.docs, (element) async{
          CommentModel commentModel = CommentModel.fromJson(element.data());
          commentModel.key = element.id;
          await FirebaseFirestore.instance.collection("user_details").doc(commentModel.commentBy).get().then((value) {
            commentModel.userName = value.get("name");
            commentModel.profile = value.get("profile");
          });
          print('==================comment profile==================');
          print(commentModel.toJson());
          setCommentList = commentModel;
        }).then((value) {
          setIsLoadingList= 1;
        });
      }
    });
  }

  addComment(String postId,comment){
    print(postId);
    FirebaseFirestore.instance.collection("posts").doc(postId).collection("comments").add({
     "comment_by":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", ""),
     "comment":comment,
     "comment_date":Timestamp.now()
    }).then((value) {
      print("============================commment===============");
      value.get().then((value) {
       print( value.data());
       CommentModel commentModel = CommentModel.fromJson(value.data()!);
       commentModel.profile = getUserDetails.email;
       commentModel.userName = getUserDetails.fistName;
       commentModel.key = value.id;
       setCommentList = commentModel;
       commentList.value.sort((a, b) => b.commentDate!.compareTo(a.commentDate!));
      });
     // fetchCommentList(postId,false);
    });
  }
}