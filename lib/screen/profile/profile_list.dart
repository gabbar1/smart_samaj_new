import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';
import 'my_family.dart';
class ProfileList extends StatelessWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        backgroundColor: Constants().mainColor,
      ),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(10),child: InkWell(
          onTap: (){
            Get.to(MyFamily());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants().mainColor.withOpacity(0.2))
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My family",style: TextStyle(fontWeight: FontWeight.bold,color: Constants().mainColor),),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants().mainColor),
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 15,color: Constants().mainColor,),)
              ],
            ),
          ),
        ),)
      ],),
    );
  }
}
