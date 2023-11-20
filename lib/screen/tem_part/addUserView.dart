import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samaj/screen/tem_part/model/addModel.dart';

import '../../commonWidget/commonWidget.dart';
import '../helper/constant.dart';
import 'controller/addController.dart';


class AddUserView extends StatefulWidget {
  String? _collectionId = "";
  UserDetailModel? _userDetailModel;
  bool? isNew;
  AddUserView(
      {String collectionId = "", UserDetailModel? userDetailModel,this.isNew }) {
    this._userDetailModel = userDetailModel;
    this._collectionId = collectionId;
  }

  @override
  _AddUserViewState createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  String _searchByValue = "Male";

  @override
  void initState() {
    // TODO: implement initState
    _emptyController();
    widget._collectionId != "" ? _fillController(widget._userDetailModel!) : "";
    _searchByValue =
        widget._collectionId != "" ? widget._userDetailModel!.gender! : "Male";
    _addController.genderController.text = _searchByValue;
    if(widget.isNew == true){
      _addController.phoneController.text = FirebaseAuth.instance.currentUser!.phoneNumber!.replaceAll("+91", "");
    }

    super.initState();
  }

  AddController _addController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: widget._collectionId == "" ? Text("Add") : Text("Update"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15, right: 15,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38,),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder( // Add this line to remove the underline
                            borderSide: BorderSide.none,
                            gapPadding: 0// This removes the border
                        ),
                      ),
                      hint: Text("Select relation with member"),
                      items: ["Father",
                        "Mother",
                        "Wife",
                        "Husband",
                        "Son",
                        "Daughter",
                        "Brother",
                        "Sister",
                        "Daughter in Law",
                        "Grandson",
                        "Granddaughter"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _addController.relationController.text = val!;
                        print("---------------value----------------");
                        print(val);
                        print(_addController.relationController.text);
                        // _myWorkController.setSelectedVersion(val);
                      },
                      value: widget._collectionId != ""
                          ? widget._userDetailModel!.relation
                          : null,
                    ),
                  ),
                ),
                CommonTextInput(
                    lable: "",
                    textInputAction: TextInputAction.next,
                    inputController: _addController.fistNameController,
                    lableTextColor: Colors.black,
                    hint: "First name"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.middleNameController,
                    hint: "Middle name"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.lastNameController,
                    hint: "Last name"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.houseNumberController,
                    hint: "House no. & colony, building, society name"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.areaNumberController,
                    hint: "Area"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.landmarkNumberController,
                    hint: "Landmark"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.cityController,
                    hint: "City"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.stateController,
                    hint: "State"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputController: _addController.pincodeController,
                    hint: "Pincode"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.countryController,
                    hint: "Country"),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputController: _addController.phoneController,
                    maxLength: 10,
                    regexp: r"^[0-9]{10}$",
                    errortext: "Enter valid Number",
                    hint: "Phone number"),
                CommonTextInput(
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  inputController: _addController.emailController,
                  hint: "Email",
                ),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.gotraController,
                    hint: "Gotra"),
                CommonTextInput(
                    textInputAction: TextInputAction.done,
                    inputController: _addController.achievementController,
                    hint: "Personal Achievements"),
                InkWell(
                  onTap: () async {
                    DateTime selectedStartDate = DateTime.now();
                    DateFormat formatter = DateFormat('dd-MM-yyyy');
                    final DateTime? picked = await showDatePicker(

                        context: context,
                        initialDate: selectedStartDate,
                        // Refer step 1
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now(),
                        builder: (BuildContext? context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: Constants().mainColor,

                              colorScheme: ColorScheme.light(
                                  primary: Constants().mainColor),
                              buttonTheme: ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        });


                    if (picked != null && picked != selectedStartDate) {
                      selectedStartDate = picked;
                      print(selectedStartDate);
                    }
                    _addController.dobController.text =
                        picked.toString().substring(0, 10);
                    Focus.of(context).unfocus();

                  },
                  child: CommonTextInput(
                      isEnabled: false,
                      inputController: _addController.dobController,
                      hint: "DOB"),
                ),
                CommonTextInput(
                    textInputAction: TextInputAction.next,
                    inputController: _addController.schoolController,
                    hint: "Firm OR School OR College Name"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Gender",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38,),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            CommonText(
                                text: 'Male',
                                textColor: Colors.black,
                                fontSize: 18),
                            Radio<String>(
                              activeColor: Constants().mainColor,
                              value: "Male",
                              groupValue: _searchByValue,
                              onChanged: (String? value) {
                                setState(() {
                                  print("-------------------");
                                  print(_searchByValue);
                                  _searchByValue = value!;
                                  _addController.genderController.text = value;
                                });
                              },
                            ),
                            CommonText(
                                text: 'Female',
                                textColor: Colors.black,
                                fontSize: 18),
                            Radio<String>(
                              activeColor: Constants().mainColor,
                              value: "Female",
                              groupValue: _searchByValue,
                              onChanged: (String? value) {
                                setState(() {
                                  _searchByValue = value!;
                                  _addController.genderController.text = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38,),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder( // Add this line to remove the underline
                          borderSide: BorderSide.none,
                          gapPadding: 0// This removes the border
                        ),
                      ),
                      hint: Text("Select Blood Group"),
                      items: ["A+", "B+", "AB+", "O+", "A-", "B-", "AB-", "O-"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _addController.bloodController.text = val!;
                        print("---------------value----------------");
                        print(val);
                        // _myWorkController.setSelectedVersion(val);
                      },
                      value: widget._collectionId != ""
                          ? widget._userDetailModel!.blood
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15, right: 15,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38,),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder( // Add this line to remove the underline
                            borderSide: BorderSide.none,
                            gapPadding: 0// This removes the border
                        ),
                      ),
                      hint: Text("Select Profession"),
                      items: [
                        "Student",
                        "Service Personnel",
                        "Self Employed",
                        "Business Owner",
                        "Unemployed",
                        "House Wife"
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _addController.professionController.text = val!;
                      },
                      value: widget._collectionId != ""
                          ? widget._userDetailModel!.profession
                          : null,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15, right: 15,),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38,),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder( // Add this line to remove the underline
                            borderSide: BorderSide.none,
                            gapPadding: 0// This removes the border
                        ),
                      ),
                      hint: Text("Marital status"),
                      items: ["Married", "Single", "Divorced", "Widowed"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        _addController.maritalController.text = val!;
                      },
                      value: widget._collectionId != ""
                          ? widget._userDetailModel!.matital
                          : null,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                widget._collectionId == ""
                    ? CommonButton(
                        buttonTextColor: Colors.white,
                        buttonText: "Submit",
                        context: context,
                        buttonColor: Constants().mainColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _addController.submitData(widget.isNew!);
                          } else {
                            commonAlertBox(
                                textColor: Constants().snackFont,
                                context: context,
                                textMessage1: "Data Not Validated.",
                                title: "Err");
                          }
                        })
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CommonButton(
                                buttonTextColor: Colors.white,
                                buttonText: "Update",
                                context: context,
                                buttonColor: Constants().mainColor,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _addController
                                        .updateData(widget._collectionId!);
                                  } else {
                                    showDialog<void>(
                                      context: Get.context!,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return commonAlertBox(
                                            context: context,
                                            textMessage1: "Data Not Validated.",
                                            title: "Err");
                                      },
                                    );
                                  }
                                }),
                          ),
                          SizedBox(width: 20,),
                          Expanded(child: CommonButton(

                              buttonTextColor: Colors.white,
                              buttonText: "Delete",
                              context: context,
                              buttonColor: Constants().mainColor,
                              onTap: () {
                                if (true) {
                                  _addController
                                      .DeleteData(widget._collectionId!);
                                } else {

                                }
                              })),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _emptyController() {
    _addController.fistNameController.text = "";
    _addController.middleNameController.text = "";
    _addController.lastNameController.text = "";
    _addController.houseNumberController.text = "";
    _addController.areaNumberController.text = "";
    _addController.landmarkNumberController.text = "";
    _addController.cityController.text = "";
    _addController.stateController.text = "";
    _addController.pincodeController.text = "";
    _addController.countryController.text = "";
    _addController.phoneController.text = "";
    _addController.emailController.text = "";
    _addController.dobController.text = "";
    _addController.genderController.text = "";
    _addController.bloodController.text = "";
    _addController.professionController.text = "";
    _addController.schoolController.text = "";
    _addController.maritalController.text = "";
    _addController.gotraController.text = "";
    _addController.achievementController.text = "";
    _addController.userPhoneController.text = "";
    _addController.relationController.text = "";
  }

  void _fillController(UserDetailModel userDetailModel) {
    _addController.fistNameController.text = userDetailModel.fistName!;
    _addController.middleNameController.text = userDetailModel.middleName!;
    _addController.lastNameController.text = userDetailModel.lastName!;
    _addController.houseNumberController.text = userDetailModel.houseNo!;
    _addController.areaNumberController.text = userDetailModel.area!;
    _addController.landmarkNumberController.text = userDetailModel.landmark!;
    _addController.cityController.text = userDetailModel.city!;
    _addController.stateController.text = userDetailModel.state!;
    _addController.pincodeController.text = userDetailModel.pincode.toString();
    _addController.countryController.text = userDetailModel.country!;
    _addController.phoneController.text = userDetailModel.phone.toString();
    _addController.emailController.text = userDetailModel.email!;
    _addController.dobController.text = userDetailModel.dob!;
    _addController.genderController.text = userDetailModel.gender!;
    _addController.bloodController.text = userDetailModel.blood!;
    _addController.professionController.text = userDetailModel.profession!;
    _addController.schoolController.text = userDetailModel.school!;
    _addController.maritalController.text = userDetailModel.matital!;
    _addController.gotraController.text = userDetailModel.gotra!;
    _addController.achievementController.text = userDetailModel.achievements!;
    _addController.userPhoneController.text = userDetailModel.userPhone!;
    _addController.relationController.text = userDetailModel.relation==null ? "":userDetailModel.relation!;
  }
}
