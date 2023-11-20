import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? commentBy;
  String? userName;
  String? profile;
  String? comment;
  Timestamp? commentDate;
  String? key;

  CommentModel({this.commentBy, this.comment, this.commentDate, this.key});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentBy = json['comment_by'];
    comment = json['comment'];
    commentDate = json['comment_date'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_by'] = this.commentBy;
    data['comment'] = this.comment;
    data['comment_date'] = this.commentDate;
    data['key'] = this.key;
    return data;
  }
}
