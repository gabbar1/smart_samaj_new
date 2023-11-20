
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samaj/commonWidget/commonWidget.dart';

import '../helper/constant.dart';

class MyFamily extends StatefulWidget {
  const MyFamily({Key? key}) : super(key: key);

  @override
  State<MyFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Family"),
        backgroundColor: Constants().mainColor,
      ),
      body: Column(children: [
            Column(children: [
          SizedBox(height: 20,),
          Center(
            child: SizedBox(width: 150,child: CommonButton(onTap: (){

            },
              buttonText: "Add Member",
              buttonColor: Constants().mainColor,

            ),),
          ),
              Divider()
        ],),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants().mainColor.withOpacity(0.2))
                  ),
                  child: Row(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(2000.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: 'https://wallpapercave.com/dwp1x/wp1812462.jpg',
                          width: 70,
                          height: 70,
                        )),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Abhishek Mishra",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      Text("Brother",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.grey),),
                    ],)
                  ],),
                ),
              );
            },))
      ],),

    );
  }
}
