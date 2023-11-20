import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/tem_part/model/addModel.dart';
import 'package:samaj/utils/utils.dart';

import '../helper/constant.dart';
import 'controller/addController.dart';
import 'controller/family_group_controller.dart';
class GroupFamilyList extends StatefulWidget {
  const GroupFamilyList({Key? key}) : super(key: key);

  @override
  State<GroupFamilyList> createState() => _GroupFamilyListState();
}

class _GroupFamilyListState extends State<GroupFamilyList> {

  FamilyGroupController _addController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    _addController.fetchFamilyGroup();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants().mainColor,
        title: Text("Family List"),
      ),
      body:
      Obx((){
        if(_addController.getLoadDataStatus == 0){
          return Center(child: CircularProgressIndicator(color: Constants().mainColor),);
        }else if(_addController.getLoadDataStatus == 2){
          return  Center(
            child: Text("No Data"),
          );
        }else if(_addController.getLoadDataStatus == 3){
          return  Center(
            child: Text("Something went wrong!!"),
          );
        }else{
         return ListView.builder(
           itemCount: _addController.getGroupedUsers.length,
           itemBuilder: (context, index) {

             String parentPhone = _addController.getGroupedUsers.keys.elementAt(index);
             List<UserDetailModel> users = _addController.getGroupedUsers[parentPhone]!;
             users.sort((a, b) =>  a.phone == int.parse(b.userPhone!) ? -1 : 1);
             print("==========grpuping");
             print(users.toList());
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(color: Colors.grey)
                 ),
                 child: Column(
                   children: [
                     Text("${users.where((element) => element.phone == int.parse(parentPhone)).isNotEmpty ? users.where((element) => element.phone == int.parse(parentPhone)).first.fistName! :parentPhone}'s Family" ),

                     Column(children: List.generate(users.length, (index) {
                       {
                         return InkWell(
                           onTap: () {

                           },
                           child: Padding(
                             padding: const EdgeInsets.only(
                                 left: 10, right: 10, top: 5, bottom: 5),
                             child: Container(
                               padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                               decoration: BoxDecoration(
                                   color: users[index].phone
                                       .toString() ==
                                       users[index].userPhone
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
                                       Text(users[index].fistName
                                           .toString()
                                           .replaceAll("null", "") +
                                           " " +
                                           users[index].middleName
                                               .toString()
                                               .replaceAll("null", "") +
                                           " " +
                                           users[index].lastName
                                               .toString()
                                               .replaceAll("null", "")),
                                       SizedBox(
                                         height: 10,
                                       ),
                                       Text(users[index].phone
                                           .toString())
                                     ],
                                   ),
                                   Column(
                                     children: [
                                       if( isNotEmptyCondition(users[index].relation))
                                         Padding(
                                           padding: const EdgeInsets.only(right: 10),
                                           child: Text(users[index].relation
                                               .toString()),
                                         ),
                                       Container(
                                         padding: const EdgeInsets.only(right: 10),
                                         child: users[index].phone
                                             .toString() ==
                                             users[index].userPhone
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
                       }
                     }),)
                   ],

                 ),
               ),
             );

          },);
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().mainColor,
        onPressed: (){
          _addController.downloadUserList();
        },
        child: Icon(Icons.download),
      ),


    );
  }
}
