import 'package:get/get.dart';

class HomeController extends GetxController{

   var count = 0;
   int get getCount => count;
   set setCount(int val){
      count = val;
   }


}