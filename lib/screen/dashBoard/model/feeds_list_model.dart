import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'like_model.dart';

class FeedsModelList {
  String? createdBy;
  String? userName;
  String? userUrl;
  Timestamp? createDate;
  int? postType;
  String? postText;
  Color? postTextColor;
  Color? postBgColor;
  int? font;
  double? fontSize;
  String? postUrl;
  int? commentCount;
  String? key;
  LikeModel? likeModel;
  FeedsModelList(
      {this.createdBy,
        this.createDate,
        this.postType,
        this.postText,
        this.postTextColor,
        this.postBgColor,
        this.font,
        this.fontSize,
        this.postUrl,
        this.key,
        this.userName,
        this.userUrl,
        this.likeModel,
        this.commentCount
      });

  FeedsModelList.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    createDate = json['create_date'];
    postType = json['post_type'];
    postText = json['post_text'];
    postTextColor = json['post_text_color']==null ? json['post_text_color']:Color(int.parse(json['post_text_color'].toString().replaceAll("Color(", "").replaceAll(")", "")));//post_bg_color
    postBgColor = json['post_bg_color'] ==null ? json['post_bg_color']:Color(int.parse(json['post_bg_color'].toString().replaceAll("Color(", "").replaceAll(")", "")));
    font = json['font'];
    fontSize = json['font_size'];
    postUrl = json['post_url'];
    userUrl = json['userUrl'];
    userName = json['userName'];
    key = json['key'];
    likeModel = json['likeModel'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    data['create_date'] = this.createDate;
    data['post_type'] = this.postType;
    data['post_text'] = this.postText;
    data['post_text_color'] = this.postTextColor;
    data['post_bg_color'] = this.postBgColor;
    data['font'] = this.font;
    data['font_size'] = this.fontSize;
    data['post_url'] = this.postUrl;
    data['userName'] = this.userName;
    data['userUrl'] = this.userUrl;
    data['key'] = this.key;
    data['likeModel'] = this.likeModel;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
