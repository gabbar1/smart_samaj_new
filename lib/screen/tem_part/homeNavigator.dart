import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/register/registerController.dart';
import 'package:samaj/screen/tem_part/controller/addController.dart';
import 'package:samaj/screen/tem_part/controller/user_detail.dart';

import '../../commonWidget/commonWidget.dart';
import '../donate/donateView.dart';
import '../helper/constant.dart';
import '../profile/profileView.dart';
import 'dashboard.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}
int _CurrentIdex=0;


Widget? callPage(int currentIdex){

  switch(currentIdex){

    case 0 : return DashBoardView();
    case 1:return  DonateView();
    case 2:return  ProfileView();

    break;

  }

}


class _HomeNavigatorState extends State<HomeNavigator> {

  CurrentUserDetails currentUserDetails = Get.put(CurrentUserDetails());
  @override
  void initState() {
    currentUserDetails.fetChCurrentUser();
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        centerTitle: true,
        elevation: 0,title: CommonText(text: "Family Details",fontSize: 18),),
      body: callPage(_CurrentIdex),
        /*bottomNavigationBar:BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.grey,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism,color: Colors.grey,),
              label: 'Donate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,color: Colors.grey,),
              label: 'Profile',
            ),
          ],
          currentIndex: _CurrentIdex,
          selectedItemColor: Constants().mainColor,
          onTap: (position) {
            setState(() {
              _CurrentIdex = position;
            });
          },
        ),*/


   );
  }
}
