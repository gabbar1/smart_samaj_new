import 'package:cloud_firestore/cloud_firestore.dart';

class MatrimonialListModel {
  String? name;
  String? lastName;
  String? gotra;
  bool? isManglik;
  Timestamp? dob;
  String? birthPlace;
  num? height;
  num? weight;
  String? qualification;
  String? hobbies;
  String? occupation;
  num? income;
  String? fatherName;
  String? fatherOccupation;
  String? motherName;
  String? motherOccupation;
  bool? isSibling;
  String? createdBy;
  bool? isActive;
  bool? isGirl;
  Timestamp? createDate;
  String? key;
  String? image_url;

  MatrimonialListModel(
      {
        this.key,
        this.name,
        this.lastName,
        this.gotra,
        this.isManglik,
        this.dob,
        this.birthPlace,
        this.height,
        this.weight,
        this.qualification,
        this.hobbies,
        this.occupation,
        this.income,
        this.fatherName,
        this.fatherOccupation,
        this.motherName,
        this.motherOccupation,
        this.isSibling,
        this.createdBy,
        this.isActive,
        this.isGirl,
        this.createDate,
        this.image_url
      });

  MatrimonialListModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    lastName = json['last_name'];
    gotra = json['gotra'];
    isManglik = json['isManglik'];
    dob = json['dob'];
    birthPlace = json['birth_place'];
    height = num.parse(json['height']);
    weight = num.parse(json['weight']);
    qualification = json['qualification'];
    hobbies = json['hobbies'];
    occupation = json['occupation'];
    income = num.parse(json['income']);
    fatherName = json['father_name'];
    fatherOccupation = json['father_occupation'];
    motherName = json['mother_name'];
    motherOccupation = json['mother_occupation'];
    isSibling = json['isSibling'];
    createdBy = json['createdBy'];
    isActive = json['isActive'];
    isGirl = json['isGirl'];
    createDate = json['create_date'];
    image_url = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['gotra'] = this.gotra;
    data['isManglik'] = this.isManglik;
    data['dob'] = this.dob;
    data['birth_place'] = this.birthPlace;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['qualification'] = this.qualification;
    data['hobbies'] = this.hobbies;
    data['occupation'] = this.occupation;
    data['income'] = this.income;
    data['father_name'] = this.fatherName;
    data['father_occupation'] = this.fatherOccupation;
    data['mother_name'] = this.motherName;
    data['mother_occupation'] = this.motherOccupation;
    data['isSibling'] = this.isSibling;
    data['createdBy'] = this.createdBy;
    data['isActive'] = this.isActive;
    data['isGirl'] = this.isGirl;
    data['create_date'] = this.createDate;
    data['image_url'] = this.image_url;
    return data;
  }
}
