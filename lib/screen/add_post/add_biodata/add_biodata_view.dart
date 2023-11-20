import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:samaj/commonWidget/commonWidget.dart';
import 'package:samaj/screen/add_post/add_biodata/add_biodata_controller.dart';
import 'package:samaj/screen/add_post/add_biodata/model/sibling_model.dart';
import 'package:samaj/screen/helper/constant.dart';

class AddBioDataView extends StatelessWidget {
  AddBioDataController addBioDataController = Get.put(AddBioDataController());


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSiblingKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: const Text("Add matrimonial biodata "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: addBioDataController.name,
                  decoration: InputDecoration(
                    hintText: "Enter name",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.lName,
                  decoration: InputDecoration(
                    hintText: "Enter last name",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.gotra,
                  decoration: InputDecoration(
                    hintText: "Enter gotra",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.gender,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Enter gender",
                      contentPadding: EdgeInsets.all(25),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Constants().mainColor,
                      )),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: false,
                        backgroundColor: Colors.white,
                        //isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (builder) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Select Gender",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Obx(
                                    () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsGirl = true;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                      addBioDataController.getIsGirl ==
                                          true
                                          ? Constants()
                                          .subTitleColor
                                          .withOpacity(0.2)
                                          : Colors.white,
                                      child: Center(
                                          child: Text(
                                            "Girl",
                                            style: TextStyle(
                                                color: addBioDataController
                                                    .getIsGirl ==
                                                    true
                                                    ? Constants().mainColor
                                                    : Colors.black),
                                          )),
                                    )),
                              ),
                              Obx(
                                    () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsGirl = false;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                      addBioDataController.getIsGirl ==
                                          false
                                          ? Constants()
                                          .subTitleColor
                                          .withOpacity(0.2)
                                          : Colors.white,
                                      child: Center(
                                          child: Text(
                                            "Boy",
                                            style: TextStyle(
                                                color: addBioDataController
                                                    .getIsGirl ==
                                                    false
                                                    ? Constants().mainColor
                                                    : Colors.black),
                                          )),
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 50, right: 50),
                                child: CommonButton(
                                  onTap: () {
                                    print("=====fff=");
                                    addBioDataController.gender.text = addBioDataController.getIsGirl ==
                                        true
                                        ? "Girl"
                                        : "Boy";
                                    Navigator.pop(context);
                                  },
                                  buttonText: "Add Gender",
                                  context: Get.context,
                                  buttonColor: Constants().mainColor,
                                  buttonTextColor: Colors.white,
                                  buttonTextStyle: FontWeight.bold,
                                  buttonTextSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 2.5,
                              )
                            ],
                          );
                        });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.manglik,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Enter manglik status",
                      contentPadding: EdgeInsets.all(25),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Constants().mainColor,
                      )),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: false,
                        backgroundColor: Colors.white,
                        //isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (builder) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Manglik Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsManglik = true;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                          addBioDataController.getIsManglik ==
                                                  true
                                              ? Constants()
                                                  .subTitleColor
                                                  .withOpacity(0.2)
                                              : Colors.white,
                                      child: Center(
                                          child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: addBioDataController
                                                        .getIsManglik ==
                                                    true
                                                ? Constants().mainColor
                                                : Colors.black),
                                      )),
                                    )),
                              ),
                              Obx(
                                () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsManglik = false;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                          addBioDataController.getIsManglik ==
                                                  false
                                              ? Constants()
                                                  .subTitleColor
                                                  .withOpacity(0.2)
                                              : Colors.white,
                                      child: Center(
                                          child: Text(
                                        "No",
                                        style: TextStyle(
                                            color: addBioDataController
                                                        .getIsManglik ==
                                                    false
                                                ? Constants().mainColor
                                                : Colors.black),
                                      )),
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: CommonButton(
                                  onTap: () {
                                    print("=====fff=");
                                    addBioDataController.manglik.text =
                                        addBioDataController.getIsManglik ==
                                                true
                                            ? "Yes"
                                            : "No";
                                    Navigator.pop(context);
                                  },
                                  buttonText: "Add Post",
                                  context: Get.context,
                                  buttonColor: Constants().mainColor,
                                  buttonTextColor: Colors.white,
                                  buttonTextStyle: FontWeight.bold,
                                  buttonTextSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 2.5,
                              )
                            ],
                          );
                        });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  controller: addBioDataController.dob,
                  decoration: InputDecoration(
                    hintText: "Enter date of birth",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    _selectDate();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.birthPlace,
                  decoration: InputDecoration(
                    hintText: "Enter location",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addBioDataController.height,
                        decoration: InputDecoration(
                          hintText: "Enter Height",
                          contentPadding: EdgeInsets.all(25),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.length == 0) {
                            return "field is required";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: addBioDataController.weight,
                        decoration: InputDecoration(
                          hintText: "Enter Weight",
                          contentPadding: EdgeInsets.all(25),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Constants().borderColor,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.length == 0) {
                            return "field is required";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.education,
                  decoration: InputDecoration(
                    hintText: "Educational Qualification",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.hobby,
                  decoration: InputDecoration(
                    hintText: "Hobby",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.occupation,
                  decoration: InputDecoration(
                    hintText: "Occupation",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.income,
                  decoration: InputDecoration(
                    hintText: "Income",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.fatherName,
                  decoration: InputDecoration(
                    hintText: "Father name",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.fatherOccupation,
                  decoration: InputDecoration(
                    hintText: "Father occupation",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.motherName,
                  decoration: InputDecoration(
                    hintText: "Mother name",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addBioDataController.motherOccupation,
                  decoration: InputDecoration(
                    hintText: "Mother occupation",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: false,
                        backgroundColor: Colors.white,
                        //isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (builder) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Do you have siblings?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsSiblings = true;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                          addBioDataController.getIsSiblings ==
                                                  true
                                              ? Constants()
                                                  .subTitleColor
                                                  .withOpacity(0.2)
                                              : Colors.white,
                                      child: Center(
                                          child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: addBioDataController
                                                        .getIsSiblings ==
                                                    true
                                                ? Constants().mainColor
                                                : Colors.black),
                                      )),
                                    )),
                              ),
                              Obx(
                                () => InkWell(
                                    onTap: () {
                                      addBioDataController.setIsSiblings =
                                          false;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(20),
                                      color:
                                          addBioDataController.getIsSiblings ==
                                                  false
                                              ? Constants()
                                                  .subTitleColor
                                                  .withOpacity(0.2)
                                              : Colors.white,
                                      child: Center(
                                          child: Text(
                                        "No",
                                        style: TextStyle(
                                            color: addBioDataController
                                                        .getIsSiblings ==
                                                    false
                                                ? Constants().mainColor
                                                : Colors.black),
                                      )),
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: CommonButton(
                                  onTap: () {
                                    print("=====fff=");
                                    addBioDataController.isSibling.text =
                                        addBioDataController.getIsSiblings ==
                                                true
                                            ? "Yes"
                                            : "No";
                                    Navigator.pop(context);
                                  },
                                  buttonText: "Done",
                                  context: Get.context,
                                  buttonColor: Constants().mainColor,
                                  buttonTextColor: Colors.white,
                                  buttonTextStyle: FontWeight.bold,
                                  buttonTextSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 2.5,
                              )
                            ],
                          );
                        });
                  },
                  controller: addBioDataController.isSibling,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Siblings",
                      contentPadding: EdgeInsets.all(25),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants().borderColor,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Constants().mainColor,
                      )),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (addBioDataController.getIsSiblings == true) {
                    return Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addBioDataController.getSiblingList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sibling ${index + 1}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          addBioDataController.siblingList.value
                                              .removeAt(index);
                                          addBioDataController.siblingList
                                              .refresh();
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: TextEditingController(
                                      text: addBioDataController
                                          .getSiblingList[index].siblingName),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Sibling's name",
                                    contentPadding: EdgeInsets.all(25),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: TextEditingController(
                                      text: addBioDataController
                                          .getSiblingList[index]
                                          .siblingOccupation),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Sibling's occupation",
                                    contentPadding: EdgeInsets.all(25),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: TextEditingController(
                                      text: addBioDataController
                                                  .getSiblingList[index]
                                                  .isBrother ==
                                              true
                                          ? "Brother"
                                          : "Sister"),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Sibling's relation",
                                    contentPadding: EdgeInsets.all(25),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: TextEditingController(
                                      text: addBioDataController
                                                  .getSiblingList[index]
                                                  .isYounger ==
                                              true
                                          ? "Younger"
                                          : "Elder"),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Siblingis younger or elder",
                                    contentPadding: EdgeInsets.all(25),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Constants().borderColor,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.length == 0) {
                                      return "field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider()
                              ],
                            );
                          },
                        ),
                        if(addBioDataController.getIsDone==false) Form(
                         key: _formSiblingKey,
                            child: Column(
                          children: [
                            TextFormField(
                              controller: addBioDataController.siblingName,
                              decoration: InputDecoration(
                                hintText: "Sibling's name",
                                contentPadding: EdgeInsets.all(25),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.length == 0) {
                                  return "field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: addBioDataController.siblingOccupation,
                              decoration: InputDecoration(
                                hintText: "Sibling's occupation",
                                contentPadding: EdgeInsets.all(25),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.length == 0) {
                                  return "field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: false,
                                    backgroundColor: Colors.white,
                                    //isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Sibling's relation",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Obx(
                                                () => InkWell(
                                                onTap: () {
                                                  addBioDataController
                                                      .setIsBrother = false;
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(20),
                                                  color: addBioDataController
                                                      .getIsBrother ==
                                                      false
                                                      ? Constants()
                                                      .subTitleColor
                                                      .withOpacity(0.2)
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                        "Sister",
                                                        style: TextStyle(
                                                            color: addBioDataController
                                                                .getIsBrother ==
                                                                true
                                                                ? Constants()
                                                                .mainColor
                                                                : Colors.black),
                                                      )),
                                                )),
                                          ),
                                          Obx(
                                                () => InkWell(
                                                onTap: () {
                                                  addBioDataController
                                                      .setIsBrother = true;
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(20),
                                                  color: addBioDataController
                                                      .getIsBrother ==
                                                      true
                                                      ? Constants()
                                                      .subTitleColor
                                                      .withOpacity(0.2)
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                        "Brother",
                                                        style: TextStyle(
                                                            color: addBioDataController
                                                                .getIsBrother ==
                                                                false
                                                                ? Constants()
                                                                .mainColor
                                                                : Colors.black),
                                                      )),
                                                )),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50, right: 50),
                                            child: CommonButton(
                                              onTap: () {
                                                print("=====fff=");
                                                addBioDataController.sister.text =
                                                addBioDataController
                                                    .getIsBrother ==
                                                    true
                                                    ? "Brother"
                                                    : "Sister";
                                                Navigator.pop(context);
                                              },
                                              buttonText: "Done",
                                              context: Get.context,
                                              buttonColor:
                                              Constants().mainColor,
                                              buttonTextColor: Colors.white,
                                              buttonTextStyle: FontWeight.bold,
                                              buttonTextSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2.5,
                                          )
                                        ],
                                      );
                                    });
                              },
                              readOnly: true,
                              controller: addBioDataController.sister,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Constants().mainColor,
                                ),
                                hintText: "Sibling's relation",
                                contentPadding: EdgeInsets.all(25),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.length == 0) {
                                  return "field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: false,
                                    backgroundColor: Colors.white,
                                    //isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Sibling is younger or elder ?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Obx(
                                                () => InkWell(
                                                onTap: () {
                                                  addBioDataController
                                                      .setIsYounger = false;
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(20),
                                                  color: addBioDataController
                                                      .getIsYounger ==
                                                      false
                                                      ? Constants()
                                                      .subTitleColor
                                                      .withOpacity(0.2)
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                        "Elder",
                                                        style: TextStyle(
                                                            color: addBioDataController
                                                                .getIsYounger ==
                                                                true
                                                                ? Constants()
                                                                .mainColor
                                                                : Colors.black),
                                                      )),
                                                )),
                                          ),
                                          Obx(
                                                () => InkWell(
                                                onTap: () {
                                                  addBioDataController
                                                      .setIsYounger = true;
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(20),
                                                  color: addBioDataController
                                                      .getIsYounger ==
                                                      true
                                                      ? Constants()
                                                      .subTitleColor
                                                      .withOpacity(0.2)
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                        "Younger",
                                                        style: TextStyle(
                                                            color: addBioDataController
                                                                .getIsYounger ==
                                                                false
                                                                ? Constants()
                                                                .mainColor
                                                                : Colors.black),
                                                      )),
                                                )),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50, right: 50),
                                            child: CommonButton(
                                              onTap: () {
                                                print("=====fff=");
                                                addBioDataController.younger.text =
                                                addBioDataController
                                                    .getIsYounger ==
                                                    true
                                                    ? "Younger"
                                                    : "Elder";
                                                Navigator.pop(context);
                                              },
                                              buttonText: "Done",
                                              context: Get.context,
                                              buttonColor:
                                              Constants().mainColor,
                                              buttonTextColor: Colors.white,
                                              buttonTextStyle: FontWeight.bold,
                                              buttonTextSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2.5,
                                          )
                                        ],
                                      );
                                    });
                              },
                              readOnly: true,
                              controller: addBioDataController.younger,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Constants().mainColor,
                                ),
                                hintText: "Sibling is younger or elder",
                                contentPadding: EdgeInsets.all(25),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Constants().borderColor,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val!.length == 0) {
                                  return "field is required";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                if(addBioDataController.getIsDone==false)...[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: (){
                                       if( _formSiblingKey.currentState!.validate()){
                                         addBioDataController.setSiblingList =
                                             SiblingModel(
                                                 siblingName: addBioDataController.siblingName.text,
                                                 siblingOccupation:
                                                 addBioDataController.siblingOccupation.text,
                                                 isBrother: addBioDataController
                                                     .getIsBrother,
                                                 isYounger: addBioDataController
                                                     .getIsYounger);
                                         addBioDataController.siblingName.clear();
                                         addBioDataController.siblingOccupation.clear();
                                         addBioDataController.sister.clear();
                                         addBioDataController.younger.clear();
                                          addBioDataController.setIsDone = true;
                                        }

                                      },
                                      child: Container(

                                        decoration: BoxDecoration(
                                            color: Constants()
                                                .mainColor
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10)),
                                        width: 100,
                                        height: 55,
                                        child: Center(
                                          child: Text(
                                            "Done",
                                            style: TextStyle(
                                                color: Constants().mainColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],


                              ],
                            ),

                            SizedBox(
                              height: 30,
                            )
                          ],
                        )),
                        if(addBioDataController.getIsDone==true)...[
                          Padding(padding: EdgeInsets.all(8),child: InkWell(
                            onTap: (){

                              addBioDataController.setIsDone = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Constants()
                                      .mainColor
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 100,
                              height: 55,
                              child: Center(
                                child: Text(
                                  "Add More",
                                  style: TextStyle(
                                      color: Constants().mainColor),
                                ),
                              ),
                            ),
                          ),)],
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                }),
                Obx(() {
                  if (addBioDataController.getIsSiblings == true) {
                    return SizedBox(
                      height: 20,
                    );
                  } else {
                    return SizedBox();
                  }
                }),
                TextFormField(
                  onTap: () {
                    if (addBioDataController.getProfilePictures.length < 5) {
                      showImagePicker();
                    } else {
                      Get.snackbar("Alert", "Only 5 images are allowed",
                          backgroundColor: Constants().mainColor,
                          colorText: Colors.white);
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Upload photos",
                    contentPadding: EdgeInsets.all(25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants().borderColor,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (addBioDataController.getProfilePictures.length == 0) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                          addBioDataController.getProfilePictures.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54)),
                                child: Card(
                                    child: Image.file(
                                  File(addBioDataController
                                      .getProfilePictures[index]),
                                  fit: BoxFit.fill,
                                )),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    maxRadius: 10,
                                    backgroundColor: Constants().mainColor,
                                    child: Icon(
                                      Icons.clear,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    addBioDataController.profilePictures.value
                                        .removeAt(index);
                                    addBioDataController.profilePictures
                                        .refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("===");
                      addBioDataController.uploadCandidateWidget();
                    }else{

                    }
                  },
                  buttonText: "Add Post",
                  context: Get.context,
                  buttonColor: Constants().mainColor,
                  buttonTextColor: Colors.white,
                  buttonTextStyle: FontWeight.bold,
                  buttonTextSize: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: addBioDataController.getSelectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Constants().mainColor,
              onPrimary: Colors.white,
              surface: Constants().mainColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != addBioDataController.getSelectedDate) {
      addBioDataController.dob.text = DateFormat.yMMMMEEEEd().format(picked);
      addBioDataController.setSelectedDate = picked;
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(Get.context!).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final imagePicker = ImagePicker();
  _imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
        maxWidth: 512,
        maxHeight: 512);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Adjust Image",
            toolbarColor: Constants().mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(minimumAspectRatio: 1.0)
      ],
    );
    addBioDataController.setProfilePictures = croppedFile!.path;
  }

  _imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 75,
        maxWidth: 512,
        maxHeight: 512);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Adjust Image",
            toolbarColor: Constants().mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(minimumAspectRatio: 1.0)
      ],
    );

    addBioDataController.setProfilePictures = croppedFile!.path;
  }
}
