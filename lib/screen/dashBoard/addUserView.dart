/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../commonWidget/commonWidget.dart';
import '../helper/constant.dart';
import 'controller/dashboard_controller.dart';

class AddUserView extends StatefulWidget {


  @override
  _AddUserViewState createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  String _searchByValue = "Male";
  AddController _addController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: Text("Add"),
      ),
      body: SingleChildScrollView(
        child: Form(key:_formKey ,child: Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),child: Column(children: [
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.fistNameController,
              hint: "first name"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.middleNameController,
              hint: "middle name"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.lastNameController,
              hint: "last name"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.houseNumberController,
              hint: "house no. & colony, building, society name"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.areaNumberController,
              hint: "area"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.landmarkNumberController,
              hint: "landmark"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.cityController,
              hint: "city"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              inputController: _addController.stateController,
              hint: "state"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              textInputType: TextInputType.number,
              inputController: _addController.pincodeController,
              hint: "picode"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              textInputType: TextInputType.number,
              inputController: _addController.phoneController,
              hint: "phone number"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              inputController: _addController.emailController,
              hint: "email",
          ),

          InkWell(
            onTap: () async{
              DateTime selectedStartDate = DateTime.now();
              DateFormat formatter = DateFormat('dd-MM-yyyy');
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedStartDate, // Refer step 1
                    firstDate:  DateTime(1800),
                    lastDate: DateTime.now(),
                    builder: (BuildContext? context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Constants().mainColor,
                          accentColor: Constants().mainColor,
                          colorScheme:
                          ColorScheme.light(primary: Constants().mainColor),
                          buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    });
                print("---------------PickedDate------------------");
                print(picked);

                if (picked != null && picked != selectedStartDate) {
                  selectedStartDate = picked;
                  print(selectedStartDate);
                }
              _addController.dobController.text = picked.toString().substring(0,10);
              Focus.of(context).unfocus();
                // strStartDate = formatter.format(selectedStartDate);
               // selectedDate(formatter.format(selectedStartDate));
              }
            ,
            child: CommonTextInput(
              isEnabled: false,
                inputController: _addController.dobController,
                hint: "DOB"
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Gender",
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child:  Row(
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
                ),)
            ],
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonFormField(
              hint: Text("select blood group"),
              items: ["A+","B+","AB+","O+","A-","B-","AB-","O-"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (val) {
                _addController.bloodController.text = val!;
                print(
                    "---------------value----------------");
                print(val);
                // _myWorkController.setSelectedVersion(val);
              },
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonFormField(
              hint: Text("select profession"),
              items: ["Student","Service Personnel","Self Employed","Business Owner"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (val) {
                _addController.professionController.text = val!;

              },
            ),
          ),
          CommonTextInput(
              inputController: _addController.schoolController,
              hint: "Firm OR School OR College Name"
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonFormField(
              hint: Text("marital status"),
              items: ["married","single","divorced","widowed"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (val) {
                _addController.maritalController.text = val!;

              },
            ),
          ),
          CommonTextInput(
              inputController: _addController.gotraController,
              hint: "Gotra"
          ),
          CommonTextInput(
              textInputAction:TextInputAction.done,
              inputController: _addController.achievementController,
              hint: "Personal Achievements"
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              if(_formKey.currentState!.validate()){
                _addController.submitData();
              }
            },
            child: Container(
                width: MediaQuery.of(context!).size.width,
                height: MediaQuery.of(context!).size.height / 15,
                decoration: BoxDecoration(
                  color: Constants().mainColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                    child: CommonText(
                        text: "Submit",
                        textColor: Colors.white,
                        ))),
          ),
          CommonButton(buttonTextColor: Colors.white,buttonText: "Submit",context: context,buttonColor: Constants().mainColor,onTap: (){
            if(_formKey.currentState!.validate()){
              _addController.submitData();
            }
          })

        ],),),),
      ),
    );
  }
}
*/
