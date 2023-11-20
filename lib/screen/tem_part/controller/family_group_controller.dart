import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samaj/commonWidget/loader.dart';
import 'package:samaj/screen/tem_part/model/addModel.dart';
import 'package:collection/collection.dart';
class FamilyGroupController extends GetxController{


  var loadDataStatus = 0.obs;
  int get getLoadDataStatus => loadDataStatus.value;
  set setLoadDataStatus(int val){
    loadDataStatus.value = val;
    notifyChildrens();
  }

  var userList = <UserDetailModel>[].obs;
  List<UserDetailModel> get getUserList => userList.value;


  set setUserList(UserDetailModel val){
    if(val.userPhone !=null || val.phone !=null)
    userList.value.add(val);
    print("=======getUserList.toList()=====");
    getUserList.forEach((element) {
      print(element.userPhone);
    });
   // print(jsonEncode(getUserList.toList()));
    userList.refresh();
  }

  //Map<String, List<UserDetailModel>> groupedUsers = {};
  var _groupedUsers = <String, List<UserDetailModel>>{}.obs;

  // Getter for groupedUsers
  Map<String, List<UserDetailModel>> get getGroupedUsers => _groupedUsers;

  // Setter for groupedUsers
  set setGroupedUsers(Map<String, List<UserDetailModel>> value) {
    _groupedUsers.value = value;
    _groupedUsers.refresh();

  }


  fetchFamilyGroup(){
    try{
      userList.value.clear();
      userList.refresh();
      FirebaseFirestore.instance.collection("user_details").get().then((value) {
        if(value.size!=0){
          value.docs.forEach((element) {
          //  print(element.data());
            UserDetailModel userDetailModel =UserDetailModel.fromJson(element.data(), element.id);
           // print("================");
           // print(userDetailModel.toJson());
            setUserList = userDetailModel;

          });
          setGroupedUsers = groupBy(getUserList, (UserDetailModel user) => user.userPhone==null ? "0":user.userPhone!);
          setLoadDataStatus = 1;

        }
        else{
          setLoadDataStatus = 2;
        }
      });
    }catch(e){
      setLoadDataStatus= 3;
      throw e;
    }

  }

  var  adminList =<String>[].obs;
  List<String> get getAdminList =>adminList;
  set setAdminList(String val){
    adminList.value.add(val);
    adminList.refresh();
  }
  fetchAdminList(){
    adminList.value.clear();
    adminList.refresh();
    FirebaseFirestore.instance.collection("admins").get().then((value) {
      value.docs.forEach((element) {
        setAdminList = element.get("phone").toString();
      });
    });
  }


  downloadUserList()async{
    try{
      showLoader();
      print("===========start========");
      final excel = Excel.createExcel();
      final sheet = excel['Family-Details'];
      final headerStyle = CellStyle(
        backgroundColorHex: "#3498db",
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#ffffff",
      );
      sheet.appendRow(["FistName", "MiddleName","LastName","HouseNo","Area","Landmark","City","State",
        "Pincode","Country","Phone","Email","DOB","Gender","Blood","Profession","Gotra","Married","Family"
      ],);
      getGroupedUsers.forEach((key, value) async {


        var family =  value.where((element) => element.phone == int.parse(key)).isNotEmpty ? value.where((element) => element.phone == int.parse(key)).first.fistName! :key;
        for(int i=0;i<value.length;i++) {
          sheet.appendRow([value[i].fistName,value[i].middleName,value[i].lastName,value[i].houseNo,value[i].area,value[i].landmark,value[i].city,value[i].state,value[i].pincode,value[i].country,value[i].phone,value[i].email,value[i].dob,value[i].gender,
            value[i].blood,value[i].profession,value[i].gotra,value[i].matital,family
          ],);

        }
        print( sheet.row(0).toList());
        for(int j=0;j<sheet.rows.length;j++){
          if(j==0){
            //  sheet.rows[j].
          }
          // print(sheet.rows[j]);
        }



      });
      final ByteData bytes = ByteData.sublistView(Uint8List.fromList(excel.encode()!));
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/family_list.xlsx';
      File(path).writeAsBytesSync(bytes.buffer.asUint8List());
      closeLoader();
      OpenFilex.open(path);
      print('Excel file saved at: $path');
      print("===========end========");
    }catch(e){
      closeLoader();
    }




  }




}