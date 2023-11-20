import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/helper/constant.dart';

commonSnackBar({String? title,String? message}){
  Get.snackbar(title!, message!,backgroundColor: Constants().mainColor,colorText: Colors.white);
}