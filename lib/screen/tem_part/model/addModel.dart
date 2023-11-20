
class UserDetailModel {
  String? id;
  String? fistName;
  String? middleName;
  String? lastName;
  String? houseNo;
  String? area;
  String? landmark;
  String? city;
  String? state;
  int? pincode;
  String? country;
  int? phone;
  String? email;
  String? dob;
  String? gender;
  String? blood;
  String? profession;
  String? school;
  String? matital;
  String? gotra;
  String? achievements;
  String? userPhone;
  String? relation;

  UserDetailModel(
      {this.id,
        this.fistName,
        this.middleName,
        this.lastName,
        this.houseNo,
        this.area,
        this.landmark,
        this.city,
        this.state,
        this.pincode,
        this.country,
        this.phone,
        this.email,
        this.dob,
        this.gender,
        this.blood,
        this.profession,
        this.school,
        this.matital,
        this.gotra,
        this.achievements,
      this.userPhone,
        this.relation
      });

  UserDetailModel.fromJson(Map<String, dynamic> json,String Id) {
    id = Id;
    fistName = json['fist-name'];
    middleName = json['middle-name'];
    lastName = json['last-name'];
    houseNo = json['house-no'];
    area = json['area'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    blood = json['blood'];
    profession = json['profession'];
    school = json['school'];
    matital = json['matital'];
    gotra = json['gotra'];
    achievements = json['achievements'];
    userPhone = json['userPhone'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fist-name'] = this.fistName;
    data['middle-name'] = this.middleName;
    data['last-name'] = this.lastName;
    data['house-no'] = this.houseNo;
    data['area'] = this.area;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['blood'] = this.blood;
    data['profession'] = this.profession;
    data['school'] = this.school;
    data['matital'] = this.matital;
    data['gotra'] = this.gotra;
    data['achievements'] = this.achievements;
    data['userPhone'] = this.userPhone;
    data['relation'] = this.relation;
    return data;
  }
}
