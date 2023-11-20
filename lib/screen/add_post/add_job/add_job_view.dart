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

import 'add_job_controller.dart';

class AddJobView extends StatelessWidget {
  AddJobController addBioDataController = Get.put(AddJobController());


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSiblingKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: const Text("Add Job Post"),
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
                    hintText: "Enter Job Title",
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
                  controller: addBioDataController.companyName,
                  decoration: InputDecoration(
                    hintText: "Enter Company Name",
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
                  controller: addBioDataController.experienceController,
                  decoration: InputDecoration(
                      hintText: "Enter Experience",
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
                  maxLines: 10,
                  controller: addBioDataController.designationController,
                  decoration: InputDecoration(
                    hintText: "Enter Job Description",
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

                  controller: addBioDataController.salaryController,
                  decoration: InputDecoration(
                    hintText: "Enter Per Month Salary",
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
                  controller: addBioDataController.locationController,
                  decoration: InputDecoration(
                    hintText: "Enter Location",
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
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: addBioDataController.whatsAppController,
                  decoration: InputDecoration(
                    hintText: "Enter WhatsApp Number",
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
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      addBioDataController.addJobPost();
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


}
