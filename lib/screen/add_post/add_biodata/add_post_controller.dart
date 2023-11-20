import 'package:get/get.dart';

class AddPostController extends GetxController{

  var postNumber = 0.obs;
  int get getPostNumber => postNumber.value;
  set setPostNumber(int val){
    postNumber.value = val;
    postNumber.refresh();
  }
}