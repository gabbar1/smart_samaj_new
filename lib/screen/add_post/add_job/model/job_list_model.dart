import 'package:cloud_firestore/cloud_firestore.dart';

class JobPostListModel {
  String? jobTitle;
  String? companyName;
  String? experience;
  String? designation;
  String? salary;
  String? whatsappNumber;
  String? description;
  Timestamp? createDate;
  String? createdBy;
  String? location;
  bool? isActive;
  String? key;

  JobPostListModel(
      {this.jobTitle,
        this.companyName,
        this.experience,
        this.designation,
        this.salary,
        this.whatsappNumber,
        this.description,
        this.createDate,
        this.createdBy,
        this.isActive,
        this.location,
        this.key});

  JobPostListModel.fromJson(Map<String, dynamic> json) {
    jobTitle = json['job_title'];
    companyName = json['company_name'];
    experience = json['experience'];
    designation = json['Designation'];
    salary = json['salary'];
    whatsappNumber = json['whatsapp_number'];
    description = json['description'];
    createDate = json['create_date'];
    createdBy = json['created_by'];
    location = json['location'];
    isActive = json['isActive'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_title'] = this.jobTitle;
    data['company_name'] = this.companyName;
    data['experience'] = this.experience;
    data['Designation'] = this.designation;
    data['salary'] = this.salary;
    data['whatsapp_number'] = this.whatsappNumber;
    data['description'] = this.description;
    data['create_date'] = this.createDate;
    data['created_by'] = this.createdBy;
    data['isActive'] = this.isActive;
    data['location'] = this.location;
    data['key'] = this.key;
    return data;
  }
}
