import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/register/registerPage.dart';
import '../add_post/add_post_view.dart';
import '../donate/donateView.dart';
import '../helper/constant.dart';
import '../jobs/job_list_view.dart';
import '../member_list/member_list_view.dart';
import '../metrimonial_list/metrimonial_list_view.dart';
import '../profile/profileView.dart';
import '../register_insert/registerController.dart';
import '../register_insert/registerPage.dart';
import 'dashboard.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentIdex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return DashBoardView();
      case 1:
        return MemberListView();
      case 2:
        return AddPostView();
      case 3:
        return MetrimonialView();
      case 4:
        return JobsListView();
      default:
        return DashBoardView();
    }
  }

  RegisterInsertController registerController =
      Get.put(RegisterInsertController());

  @override
  void initState() {
    // TODO: implement initState
    registerController.fetchUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: Text(
          "User List",
        ),
      ),
      body: Obx(() => ListView.builder(
            itemCount: registerController.getUserDetailsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(registerController.getUserDetailsList[index].fName +
                    " " +
                    registerController.getUserDetailsList[index].lName),
                subtitle: Text(registerController.getUserDetailsList[index].phone),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().mainColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(RegisterPageInsertView());
        },
      ),
    );
    return Scaffold(
      body: callPage(_currentIdex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Constants().mainColor,
        items: <Widget>[
          SvgPicture.asset(
            "assets/icons/home.svg",
            color: _currentIdex == 0 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset("assets/icons/family.svg",
              color: _currentIdex == 1 ? Colors.white : Colors.black),
          SvgPicture.asset("assets/icons/add.svg",
              color: _currentIdex == 2 ? Colors.white : Colors.black),
          SvgPicture.asset("assets/icons/sadi.svg",
              color: _currentIdex == 3 ? Colors.white : Colors.black),
          SvgPicture.asset("assets/icons/job.svg",
              color: _currentIdex == 4 ? Colors.white : Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _currentIdex = index;
          });
        },
      ),
    );
  }
}
