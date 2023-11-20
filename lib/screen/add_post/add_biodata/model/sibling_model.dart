class SiblingModel {
  String? siblingName;
  String? siblingOccupation;
  bool? isBrother;
  bool? isYounger;

  SiblingModel({this.siblingName, this.siblingOccupation,this.isYounger,this.isBrother});

  SiblingModel.fromJson(Map<String, dynamic> json) {
    siblingName = json['siblingName'];
    siblingOccupation = json['SiblingOccupation'];
    isBrother = json['isBrother'];
    isYounger = json['isYounger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siblingName'] = this.siblingName;
    data['SiblingOccupation'] = this.siblingOccupation;
    data['isBrother'] = this.isBrother;
    data['isYounger'] = this.isYounger;
    return data;
  }
}
