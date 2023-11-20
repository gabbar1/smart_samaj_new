import 'package:flutter/material.dart';
import 'package:samaj/commonWidget/commonWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../add_post/add_job/model/job_list_model.dart';
import '../helper/constant.dart';
class JobDetails extends StatelessWidget {
      JobDetails({this.jobDetails});
      JobPostListModel? jobDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        title: Text(jobDetails!.jobTitle!),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
          Text(maxLines: 3,jobDetails!.jobTitle!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: 10,),
          Row(children: [Text("Experience",style: TextStyle(fontWeight: FontWeight.bold),),Text(": ${jobDetails!.experience}"),],),
          SizedBox(height: 10,),
          Row(children: [Text("Designation",style: TextStyle(fontWeight: FontWeight.bold),),Text(": ${jobDetails!.jobTitle}"),],),
          SizedBox(height: 10,),
          Row(children: [Text("Salary",style: TextStyle(fontWeight: FontWeight.bold),),Text(": ${jobDetails!.salary}"),],),
          SizedBox(height: 10,),
          Row(children: [Text("Location",style: TextStyle(fontWeight: FontWeight.bold),),Text(": ${jobDetails!.location}"),],),
          SizedBox(height: 10,),
          Row(children: [Text("Company Name",style: TextStyle(fontWeight: FontWeight.bold),),Text(": ${jobDetails!.companyName}"),],),
          SizedBox(height: 10,),
          Text("Description",style: TextStyle(fontWeight: FontWeight.bold),), SizedBox(height: 10,),Text("${jobDetails!.description}"),

        ],),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 50,right: 20),
        child: CommonButton(onTap: () async{
          print(jobDetails!.whatsappNumber!);
          await launch(
              "https://wa.me/+91${jobDetails!.whatsappNumber!}?text=Hello I hope you are doing well, I'm interested in your job post ${jobDetails!.jobTitle!} and I want to apply. Please let me know the futher process.");
        },buttonText: "Contact us",buttonColor: Constants().mainColor,buttonTextColor: Colors.white,),
      ),
    );
  }
}
