import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:samaj/utils/utils.dart';

import '../helper/constant.dart';
import '../register/registerController.dart';
import 'addUserView.dart';
import 'controller/addController.dart';

class DashBoardView extends StatefulWidget {
  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  AddController _addController = Get.find();
  RegisterController registerController = Get.find();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("user_details")
        .where("phone",
            isEqualTo: int.parse(FirebaseAuth.instance.currentUser!.phoneNumber!
                .replaceAll("+91", "")))
        .where("userPhone",
            isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber!
                .replaceAll("+91", ""))
        .get()
        .then((value) {
      if (value.size != 0) {
        registerController.setIsChild = false;
        _addController.showUserList(false);
      } else {
        registerController.setIsChild = true;
        _addController.showUserList(true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("registerController.getIsChild" + _addController.getUserList.toString());
    print(registerController.getIsChild);
    return Scaffold(
        body: Obx(() {
          if(_addController.getLoadDataStatus == 0){
            return Center(child: CircularProgressIndicator(color: Constants().mainColor),);
          }else if(_addController.getLoadDataStatus == 1){
           return  Center(
              child: Text("No Data"),
            );
          }else if(_addController.getLoadDataStatus == 3){
            return  Center(
              child: Text("Something went wrong!!"),
            );
          }else{
            return ListView.builder(
                itemCount: _addController.getUserList.length,
                itemBuilder: (context, index) {
                  print("----------------list creating with Item count " +
                      _addController.getUserList.length.toString());
                  return InkWell(
                    onTap: () {
                      if (registerController.getIsChild != true) {
                        Get.to(
                                () => AddUserView(
                              collectionId:
                              _addController.getUserList[index].id!,
                              userDetailModel:
                              _addController.getUserList[index],
                              isNew: false,
                            ),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 600));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        decoration: BoxDecoration(
                            color: _addController.getUserList[index].phone
                                .toString() ==
                                _addController.getUserList[index].userPhone
                                    .toString()
                                ? Constants().mainColorlight
                                : null,
                            border: Border.all(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:  [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_addController.getUserList[index].fistName
                                    .toString()
                                    .replaceAll("null", "") +
                                    " " +
                                    _addController.getUserList[index].middleName
                                        .toString()
                                        .replaceAll("null", "") +
                                    " " +
                                    _addController.getUserList[index].lastName
                                        .toString()
                                        .replaceAll("null", "")),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(_addController.getUserList[index].phone
                                    .toString())
                              ],
                            ),
                            Column(
                              children: [
                               if( isNotEmptyCondition(_addController.getUserList[index].relation))
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(_addController.getUserList[index].relation
                                      .toString()),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: _addController.getUserList[index].phone
                                      .toString() ==
                                      _addController.getUserList[index].userPhone
                                          .toString()
                                      ? Icon(Icons.face)
                                      : null,
                                  transformAlignment: Alignment.centerRight,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }


        }),
        floatingActionButton: Obx(() {
          print("=====registerController.getIsChild=");
          print(registerController.getIsChild);
          if (registerController.getIsChild == true) {
            return SizedBox();
          } else {
            return FloatingActionButton(
              onPressed: () {
                Get.to(() => AddUserView(isNew: false),
                    transition: Transition.zoom,
                    duration: Duration(milliseconds: 700));
              },
              backgroundColor: Constants().mainColor,
              child: Icon(
                Icons.add,
              ),
            );
          }
        }));
  }
}
