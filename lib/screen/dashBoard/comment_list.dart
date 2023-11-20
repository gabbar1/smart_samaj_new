import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samaj/screen/dashBoard/controller/comment_controller.dart';
import 'package:samaj/screen/dashBoard/controller/dashboard_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/constant.dart';

class CommentList extends StatefulWidget {
  CommentList({this.postId});
  String? postId;
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  DashBoardController dashBoardController = Get.find();
  CommentController commentController = Get.put(CommentController());
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    commentController.fetchUserDetails();
    commentController.fetchCommentList(widget.postId!, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
        title: Text("Comments"),
      ),
      body: Obx(() => Column(
            children: [
              if (commentController.getIsLoadingList == 0) ...[
                Expanded(
                    child: Center(
                  child: Text('wait..'),
                ))
              ] else if (commentController.getIsLoadingList == 2) ...[
                Expanded(
                    child: Center(
                  child: Text('No Comment Found..'),
                ))
              ] else ...[
                Expanded(
                    child: SmartRefresher(
                  footer: CustomFooter(
                    builder: (context, mode) {
                      if (mode == LoadStatus.idle) {
                        return GestureDetector(
                            onTap: () {
                              _refreshController.requestRefresh();
                            },
                            child: Center(child: Icon(Icons.add)));
                      } else if (mode == LoadStatus.loading) {
                        return Center(child: CupertinoActivityIndicator());
                      } else if (mode == LoadStatus.failed) {
                        return Center(child: Text("Load Failed!Click retry!"));
                      } else if (mode == LoadStatus.canLoading) {
                        return Center(child: Text("release to load more"));
                      } else {
                        return Center(child: Text("No more Data"));
                      }
                    },
                  ),
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: () {
                    commentController.fetchRefreshCommentList(widget.postId!);
                  },
                  onLoading: () {
                    commentController
                        .fetchRefreshCommentList(widget.postId!)
                        .then((value) {
                      _refreshController.loadComplete();
                    });
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                        itemCount: commentController.getCommentList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: commentController
                                      .getCommentList[index].profile!,
                                  imageBuilder: (context, imageProvider) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey),
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icons/placeholder.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 40.0,
                                    height: 40.0,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icons/placeholder.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      commentController
                                          .getCommentList[index].userName!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        commentController
                                            .getCommentList[index].comment!,
                                      ),
                                    )
                                    /* Text(
                          DateFormat.yMMMMd().format(
                              commentController
                                  .getCommentList[index].commentDate!
                                  .toDate()),
                          style: TextStyle(
                              fontSize: 13,
                              color: Constants()
                                  .subTitleColor),
                        ),*/
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )),
                      InkWell(
                          onTap: () {
                            commentController
                                .fetchRefreshCommentList(widget.postId!);
                          },
                          child: Center(child: Icon(Icons.add)))
                    ],
                  ),
                ))
              ],
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            hintText: 'Type a comment',
                            border: InputBorder.none,
                            suffix: InkWell(
                              onTap: () {
                                commentController.addComment(
                                    widget.postId!, _commentController.text);
                                _commentController.clear();
                              },
                              child: Text(
                                "Post",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
