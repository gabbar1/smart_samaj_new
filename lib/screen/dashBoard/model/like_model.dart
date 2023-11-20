import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  bool? isLike;
  Timestamp? likeDate;
  String? likeBy;
  num? count;

  LikeModel({this.isLike, this.likeDate, this.likeBy,this.count});

  LikeModel.fromJson(Map<String, dynamic> json) {
    isLike = json['isLike'];
    likeDate = json['like_date'];
    likeBy = json['like_by'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLike'] = this.isLike;
    data['like_date'] = this.likeDate;
    data['like_by'] = this.likeBy;
    data['count'] = this.count;
    return data;
  }
}
