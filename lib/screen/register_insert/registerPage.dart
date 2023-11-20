import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/register/registerController.dart';

import '../../collections/allCollections.dart';
import '../../commonWidget/commonWidget.dart';
import '../helper/constant.dart';
import 'registerController.dart';


class RegisterPageInsertView extends StatefulWidget {
  @override
  State<RegisterPageInsertView> createState() => _RegisterPageInsertViewState();
}

class _RegisterPageInsertViewState extends State<RegisterPageInsertView> {
  RegisterInsertController registerController = Get.put(RegisterInsertController());

  CommonDatePicker commonDatePicker = Get.put(CommonDatePicker());

  GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();
  String selectedGender = 'Male';
  String? selectedBloodGroup;
  String? selectedProfession;
  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<String> professions = ['Student', 'Service Personnel', 'Self Employed', 'Business Owner'];
  String? selectedMaritalStatus;
  void _handleGenderChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  void _handleBloodGroupChange(String value) {
    setState(() {
      selectedBloodGroup = value;
    });
  }
  void _handleProfessions(String value) {
    setState(() {
      selectedProfession = value;
    });
  }
  void _handleMaritalStatusChange(String value) {
    setState(() {
      selectedMaritalStatus = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    selectedBloodGroup = bloodGroups[0];
    selectedMaritalStatus = 'Single';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        centerTitle: true,
        title: CommonText(text: "Register",fontSize: 20),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Form(
          key: registerFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextInput(
                    hint: "Enter First Name",
                    inputController: registerController.fNameController,
                    lable: "Name",
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Name",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                    hint: "Enter Middle Name",
                    inputController: registerController.mNameController,
                    lable: "Name",
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Middle Name",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                    hint: "Enter Last Name",
                    inputController: registerController.lNameController,
                    lable: "Name",
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Last Name",
                ),
                SizedBox(
                  height: 10,
                ),

                CommonTextInput(
                  textInputType: TextInputType.streetAddress,
                  hint: "House no. & Colony, Building, Society Name",
                  inputController: registerController.houseNoController,
                  lable: "House no",
                  lableFontSize: 20,
                  isRequired: false,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  errortext: "Enter valid house No",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.streetAddress,
                  hint: "Enter Area",
                  inputController: registerController.areaController,
                  lable: "Area",
                  lableFontSize: 20,
                  isRequired: false,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[a-z|A-z]{3}",
                  errortext: "Enter valid Area Name",
                ),

                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.name,
                  hint: "Enter City",
                  inputController: registerController.cityController,
                  lable: "City",
                  lableFontSize: 20,
                  maxLength: 6,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  errortext: "Enter valid City",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.number,
                  hint: "Enter PinCode",
                  inputController: registerController.pincodeController,
                  lable: "Pin Code",
                  lableFontSize: 20,
                  maxLength: 6,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[0-9]{6}$",
                  errortext: "Enter valid PinCode",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                  textInputType: TextInputType.phone,
                  hint: "Enter Phone",
                  inputController: registerController.phoneController,
                  lable: "Contact Number",
                  lableFontSize: 20,
                  maxLength: 10,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                  regexp: r"^[0-9]{10}$",
                  errortext: "enter valid Number",
                ),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput(
                    textInputType: TextInputType.emailAddress,
                    hint: "Enter Email",
                    inputController: registerController.emailController,
                    lable: "Email",
                    lableFontSize: 20,
                    isRequired: false,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                    regexp: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    errortext: "enter valid email"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    onTap: (){
                      _selectDate(context);
                    },
                    readOnly: true,
                    controller: registerController.dobController,
                    style: TextStyle(color: Constants().mainColor),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter DOB",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                      ),
                      isDense: true,                      // Added this
                      contentPadding: EdgeInsets.all(25),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty ) {
                        return 'field required';
                        //"Please enter valid floor number";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Column(
                  children: <Widget>[
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Male'),
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value){
                        _handleGenderChange(value!);
                      },
                    ),
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Female'),
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value){
                        _handleGenderChange(value!);
                      },
                    ),
                    // You can add more gender options here if needed
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Select your Blood Group:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20.0),

                    Container(
                      width: double.infinity, // Makes the container take the full width
                      padding: EdgeInsets.all(10.0), // Add padding for spacing
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border
                        border: Border.all(color: Colors.grey), // Border color
                      ),
                      child: DropdownButton<String>(
                        value: selectedBloodGroup,
                        onChanged: (value) {
                          _handleBloodGroupChange(value!);
                        },
                        items: bloodGroups.map((String bloodGroup) {
                          return DropdownMenuItem<String>(
                            value: bloodGroup,
                            child: Text(bloodGroup),
                          );
                        }).toList(),
                        underline: SizedBox(),
                      ),
                    )


                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Select Profession',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20.0),

                    Container(
                      width: double.infinity, // Makes the container take the full width
                      padding: EdgeInsets.all(10.0), // Add padding for spacing
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border
                        border: Border.all(color: Colors.grey), // Border color
                      ),
                      child: DropdownButton<String>(
                        value: selectedProfession,
                        onChanged: (value) {
                          _handleProfessions(value!);
                        },
                        items: professions.map((String bloodGroup) {
                          return DropdownMenuItem<String>(
                            value: bloodGroup,
                            child: Text(bloodGroup),
                          );
                        }).toList(),
                        underline: SizedBox(),
                      ),
                    )


                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Married'),
                      value: 'Married',
                      groupValue: selectedMaritalStatus,
                      onChanged:(value){
                        _handleMaritalStatusChange(value!);
                      },
                    ),
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Single'),
                      value: 'Single',
                      groupValue: selectedMaritalStatus,
                      onChanged:(value){
                        _handleMaritalStatusChange(value!);
                      },
                    ),
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Divorced'),
                      value: 'Divorced',
                      groupValue: selectedMaritalStatus,
                      onChanged:(value){
                        _handleMaritalStatusChange(value!);
                      },
                    ),
                    RadioListTile(
                      activeColor: Constants().mainColor,
                      title: Text('Widowed'),
                      value: 'Widowed',
                      groupValue: selectedMaritalStatus,
                      onChanged:(value){
                        _handleMaritalStatusChange(value!);
                      },
                    ),
                  ],
                ),
                CommonTextInput(
                    textInputType: TextInputType.text,
                    hint: "Enter Gotra",
                    inputController: registerController.gotraController,
                    lable: "Gotra",
                    lableFontSize: 20,
                    isRequired: true,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                    regexp: "",
                    errortext: "enter valid Gotra"),
                SizedBox(
                  height: 10,
                ),
               InkWell(
          onTap: (){
            if(registerFormKey.currentState!.validate()){
              UserDetailsForm userDetails = UserDetailsForm(
                email: registerController.emailController.text,
                fName: registerController.fNameController.text,
                mName: registerController.mNameController.text,
                lName: registerController.lNameController.text,
                houseNo: registerController.houseNoController.text,
                dob: registerController.dobController.text,
                phone: registerController.phoneController.text,
                area: registerController.areaController.text,
                pincode: registerController.pincodeController.text,
                city: registerController.cityController.text,
                gotra: registerController.gotraController.text,
                gender: selectedGender, // Add the value from the genderController
                bloodGroup: selectedBloodGroup!, // Add the value from the bloodGroupController
                profession: selectedProfession!, // Add the value from the professionController
                maritalStatus: selectedMaritalStatus!,
                registerDate: Timestamp.now()// Add the value from the maritalStatusController
              );

              registerController.addUser(userDetails);

            }else{
              print("not validated");
            }
          },
          child: Container(
              width: MediaQuery.of(context!).size.width,
            height:65,
            decoration: BoxDecoration(
              color: Constants().mainColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
                child: CommonText(
                    text: "Register",
                    textColor:  Colors.white,
                    fontStyle: FontWeight.bold,
                    fontSize: 18))),
      ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
 // Initialize with the current date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      // Calculate age based on the selected date
      registerController.dobController.text = selectedDate.toUtc().toString();
    }
  }
}

class UserDetailsForm {
  String email;
  String fName;
  String mName;
  String lName;
  String houseNo;
  String dob;
  String phone;
  String area;
  String pincode;
  String city;
  String gotra;
  String gender;
  String bloodGroup;
  String profession;
  String maritalStatus;
  String? key;
  Timestamp registerDate;


  UserDetailsForm({
    required this.email,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.houseNo,
    required this.dob,
    required this.phone,
    required this.area,
    required this.pincode,
    required this.city,
    required this.gotra,
    required this.gender,
    required this.bloodGroup,
    required this.profession,
    required this.maritalStatus,
    required this.registerDate,
    this.key
  });

  factory UserDetailsForm.fromJson(Map<String, dynamic> json) {
    return UserDetailsForm(
      key: json['key'],
      email: json['email'],
      fName: json['fName'],
      mName: json['mName'],
      lName: json['lName'],
      houseNo: json['houseNo'],
      dob: json['dob'],
      phone: json['phone'],
      area: json['area'],
      pincode: json['pincode'],
      city: json['city'],
      gotra: json['gotra'],
      gender: json['gender'],
      bloodGroup: json['bloodGroup'],
      profession: json['profession'],
      maritalStatus: json['maritalStatus'],
      registerDate: json['registerDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'email': email,
      'fName': fName,
      'mName': mName,
      'lName': lName,
      'houseNo': houseNo,
      'dob': dob,
      'phone': phone,
      'area': area,
      'pincode': pincode,
      'city': city,
      'gotra': gotra,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'profession': profession,
      'maritalStatus': maritalStatus,
      'registerDate': registerDate,
    };
  }
}



