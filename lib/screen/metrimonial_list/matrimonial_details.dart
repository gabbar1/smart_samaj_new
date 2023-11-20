import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samaj/screen/helper/constant.dart';
import '../add_post/add_biodata/add_biodata_controller.dart';
import '../add_post/add_biodata/model/matrimonial_list_model.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
class MatrimonialDetails extends StatefulWidget {
  MatrimonialDetails({this.matrimonialDetails});
  MatrimonialListModel? matrimonialDetails;
  @override
  State<MatrimonialDetails> createState() => _MatrimonialDetailsState();
}

class _MatrimonialDetailsState extends State<MatrimonialDetails> {

  CarouselSliderController? _sliderController;
  AddBioDataController addBioDataController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    _sliderController = CarouselSliderController();
    addBioDataController.fetchBioDetails(widget.matrimonialDetails!.key!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          title: Text(widget.matrimonialDetails!.name! +
              " " +
              widget.matrimonialDetails!.lastName!),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Obx(()=> Container(
         height: MediaQuery.of(context).size.width/1.2,
         width: MediaQuery.of(context).size.width,
         child: CarouselSlider.builder(
             unlimitedMode: true,
             controller: _sliderController,
             slideBuilder: (index) {
               return CachedNetworkImage(imageUrl: addBioDataController.getMatrimonialProfilePicturesUrl[index],width: MediaQuery.of(context).size.width,fit: BoxFit.fill,height: MediaQuery.of(context).size.width,);
             },
             slideTransform: DefaultTransform(),
             slideIndicator: CircularSlideIndicator(
               currentIndicatorColor: Constants().mainColor,
               indicatorBackgroundColor: Constants().mainColor.withOpacity(0.3),
               padding: EdgeInsets.only(bottom: 32),
             ),
             itemCount: addBioDataController.getMatrimonialProfilePicturesUrl.length),
       )),
        SizedBox(height: 10,),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.matrimonialDetails!.name! +
                  " " +
                  widget.matrimonialDetails!.lastName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),CircleAvatar(backgroundColor: Constants().mainColor,child: IconButton(onPressed: (){
                  FlutterPhoneDirectCaller.callNumber(widget.matrimonialDetails!.createdBy!);
                }, icon: Icon(Icons.call,color: Colors.white,)),)],),
              SizedBox(height: 20,),
              Row(children: [
                Text("Gender",),
                SizedBox(width: 20),
                Text(widget.matrimonialDetails!.isGirl == true? ": Female":": Male",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 20,),
              Row(children: [
                Text("Education",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.qualification}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 20,),
              Row(children: [
                Text("Hobby",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.hobbies}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 20,),
              Row(children: [
                Text("Mangal",),
                SizedBox(width: 20),
                Text(widget.matrimonialDetails!.isManglik == true? ": Manglik":": No Manglik",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Gotra",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.gotra!}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Date of Birth",),
                SizedBox(width: 20),
                Text(": ${DateFormat(DateFormat.YEAR_MONTH_DAY, ).format(widget.matrimonialDetails!.dob!.toDate().toUtc()).toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Birth Place",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.birthPlace}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Height",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.height} .Ft",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Height",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.height} .Ft",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Weight",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.weight} .Kg",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Occupation",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.occupation}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Income",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.income}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Father Name",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.fatherName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Father Occupation",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.fatherOccupation}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Mother Name",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.motherName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Row(children: [
                Text("Mother Occupation",),
                SizedBox(width: 20),
                Text(": ${widget.matrimonialDetails!.motherOccupation}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],),
              SizedBox(height: 10,),
              Obx(() => SizedBox(child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: addBioDataController.getMatrimonialSiblingList.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    Row(children: [
                      Text("Sibling ",),
                      SizedBox(width: 20),
                      Text(": ${addBioDataController.getMatrimonialSiblingList[index].siblingName}(${addBioDataController.getMatrimonialSiblingList[index].isYounger==true? "Younger":"Elder"} ${addBioDataController.getMatrimonialSiblingList[index].isBrother==true? "Brother":"Sister"})",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ],),
                    SizedBox(height: 10,),
                  ],);
                },)))
            ],)),
        ))
      ],),
    );
  }
}
