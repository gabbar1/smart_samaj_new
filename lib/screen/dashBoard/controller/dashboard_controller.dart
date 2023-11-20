import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/feeds_list_model.dart';
import '../model/like_model.dart';



class DashBoardController extends GetxController{

var feedsList = <FeedsModelList>[].obs;
List<FeedsModelList> get getFeedsList => feedsList.value;
set setFeedsList(FeedsModelList val){
  feedsList.value.add(val);
  feedsList.refresh();
}

DocumentSnapshot? lastDocument;
fetchFeedsList() {
  feedsList.value.clear();

  FirebaseFirestore.instance.collection("posts").orderBy("create_date",descending: true).limit(3).get().then((value) {
    if(value.size!=0){
      if(value.docs.isNotEmpty){
        lastDocument = value.docs[value.docs.length -1];
      }
      print("==============fetchFeedsList=================");
      print(value.docs.toList());
      Future.forEach(value.docs, (element) async{
        FeedsModelList feedsModelList = FeedsModelList.fromJson(element.data());
        DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection("user_details").doc(feedsModelList.createdBy).get();
        feedsModelList.userName = userDetails.get("name");
        feedsModelList.userUrl = userDetails.get("profile");
        feedsModelList.key = element.id;
       await FirebaseFirestore.instance.collection("posts").doc(element.id).collection("likes").where("isLike",isEqualTo: true).get().then((value) {
          print("========================likes=========");
          LikeModel likeModel = LikeModel();
          likeModel.count = value.size;
          if(value.size==0){
            feedsModelList.likeModel = LikeModel(count: value.size,isLike: false,);
            print(feedsModelList.toJson());
            FirebaseFirestore.instance.collection("posts").doc(element.id).collection("comments").get().then((value) {
              feedsModelList.commentCount = value.size;
            });
            setFeedsList = feedsModelList;
          }
          else{
            Future.forEach(value.docs.where((element) => element.get("like_by")== FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")), (el) {
              print(el.data());
              likeModel.isLike = el.get("isLike");
              likeModel.likeDate = el.get("like_date");
              likeModel.likeBy = el.get("like_by");
              feedsModelList.likeModel = likeModel;
              print(feedsModelList.toJson());
              FirebaseFirestore.instance.collection("posts").doc(element.id).collection("comments").get().then((value) {
                feedsModelList.commentCount = value.size;
              });
              setFeedsList = feedsModelList;
            });
          }
          setIsLoadingList = 1;
        });
      });

    }
    else{
      setIsLoadingList = 2;
    }
  });


}
Future<void> refreshFeedsList() async{
  FirebaseFirestore.instance.collection("posts").orderBy("create_date",descending: true).limit(3).startAfterDocument(lastDocument!).get().then((value) {
    value.docs.forEach((element)async {
      if(value.docs.isNotEmpty){
        lastDocument = value.docs[value.docs.length -1];
      }
      FeedsModelList feedsModelList = FeedsModelList.fromJson(element.data());
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection("user_details").doc(feedsModelList.createdBy).get();
      feedsModelList.userName = userDetails.get("name");
      feedsModelList.userUrl = userDetails.get("profile");
      feedsModelList.key = element.id;
      FirebaseFirestore.instance.collection("posts").doc(element.id).collection("likes").where("isLike",isEqualTo: true).get().then((value) {
        print("========================likes=========");
        LikeModel likeModel = LikeModel();
        likeModel.count = value.size;
        if(value.size==0){
          feedsModelList.likeModel = LikeModel(count: value.size,isLike: false,);
          print(feedsModelList.toJson());
          FirebaseFirestore.instance.collection("posts").doc(element.id).collection("comments").get().then((value) {
            feedsModelList.commentCount = value.size;
          });
          setFeedsList = feedsModelList;
        }
        else{
          Future.forEach(value.docs.where((element) => element.get("like_by")== FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")), (el) {
            print(el.data());
            likeModel.isLike = el.get("isLike");
            likeModel.likeDate = el.get("like_date");
            likeModel.likeBy = el.get("like_by");
            feedsModelList.likeModel = likeModel;
            print(feedsModelList.toJson());
            FirebaseFirestore.instance.collection("posts").doc(element.id).collection("comments").get().then((value) {
              feedsModelList.commentCount = value.size;
            });
            setFeedsList = feedsModelList;
          });
        }

      });

    });

  });

}


var myFeedsList = <FeedsModelList>[].obs;
List<FeedsModelList> get getMyFeedsList => myFeedsList.value;
set setMyFeedsList(FeedsModelList val){
  myFeedsList.value.add(val);
  myFeedsList.refresh();
}

DocumentSnapshot? myLastDocument;
var isLoadingList = 0.obs;
int get getIsLoadingList => isLoadingList.value;
set setIsLoadingList(int val){
  print("=============setval=========");
  print(val);
  isLoadingList.value =val;
  isLoadingList.refresh();
}
fetchMyFeedsList() {
  myFeedsList.value.clear();

  FirebaseFirestore.instance.collection("posts").where("created_by",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).orderBy("create_date",descending: true).limit(20).get().then((value) async{
    if(value.size!=0){
      if(value.docs.isNotEmpty){
        myLastDocument = value.docs[value.docs.length -1];
      }
      await Future.forEach(value.docs, (element) async{
        FeedsModelList feedsModelList = FeedsModelList.fromJson(element.data());
        DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection("user_details").doc(feedsModelList.createdBy).get();
        feedsModelList.userName = userDetails.get("name");
        feedsModelList.userUrl = userDetails.get("profile");
        feedsModelList.key = element.id;
        setMyFeedsList = feedsModelList;
      });

    }
  });


}
Future<void> refreshMyFeedsList() async{
  FirebaseFirestore.instance.collection("posts").where("created_by",isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).orderBy("create_date",descending: true).startAfterDocument(myLastDocument!).limit(20).get().then((value) {
    value.docs.forEach((element)async {
      if(value.docs.isNotEmpty){
        myLastDocument = value.docs[value.docs.length -1];
      }
      FeedsModelList feedsModelList = FeedsModelList.fromJson(element.data());
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection("user_details").doc(feedsModelList.createdBy).get();
      feedsModelList.userName = userDetails.get("name");
      feedsModelList.userUrl = userDetails.get("profile");
      feedsModelList.key = element.id;
      setMyFeedsList = feedsModelList;
    });

  });

}

 var likePost = LikeModel().obs;
LikeModel get getLikePost => likePost.value;
set setLikePost(LikeModel val){
  likePost.value = val;
  likePost.refresh();
}
Future<void> addLikePost(String postId,bool? isLike,int index)async{
  print(postId);
  print(isLike);
  print(index);
  FirebaseFirestore.instance.collection("posts").doc(postId).collection("likes").doc(FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")).set({
    "isLike":isLike,
    "like_date":Timestamp.now(),
    "like_by":FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "")
  }).then((value) {
    fetchLikePost(postId,isLike,index);
  });
}
Future<void> fetchLikePost(String postId,bool? isLike,int index)async{
  print("==================postId===================");
  print(postId);
  LikeModel likeModel = LikeModel();
  FirebaseFirestore.instance.collection("posts").doc(postId).collection("likes").where("isLike",isEqualTo: true).get().then((value) {
    likeModel.count = value.size;
    feedsList.value[index].likeModel =LikeModel(isLike: isLike,count:value.size,likeBy: getFeedsList[index].likeModel!.likeBy,likeDate: Timestamp.now());
    feedsList.refresh();
  });
}


Future<void> fetchCommentCount(String postId)async{
  FirebaseFirestore.instance.collection("posts").doc(postId).collection("comments").get().then((value) {

  });
}

}


