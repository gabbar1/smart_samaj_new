import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samaj/screen/dashBoard/comment_list.dart';
import 'package:samaj/screen/profile/profileView.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/constant.dart';
import 'addUserView.dart';
import 'controller/dashboard_controller.dart';

class DashBoardView extends StatefulWidget {
  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  DashBoardController _dashBoardController = Get.put(DashBoardController());
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    _dashBoardController.fetchFeedsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, bottom: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ProfileView());
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://wallpapercave.com/dwp1x/wp1812462.jpg',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Abhishek Mishra",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "+91 8200127649",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/search.svg"),
                      SizedBox(width: 10),
                      SvgPicture.asset("assets/icons/notification.svg"),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() {
                print("==============_dashBoardController.getIsLoadingList==========;");
                print(_dashBoardController.getIsLoadingList);
                if (_dashBoardController.getIsLoadingList == 0) {
                   return  Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       enabled: true,
                       child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40.0,
                                      height: 40.0,

                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                        shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100.0,
                                          height: 5.0,
                                          color: Colors.black,

                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          width: 30.0,
                                          height: 5.0,
                                          color: Colors.black,

                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          height: 25,
                                          "assets/icons/like.svg",
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          height: 25,
                                          "assets/icons/comment.svg",
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/share.svg",
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                  ),
                     ),
                   );
                }
                else{
                  return SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: () {
                      _dashBoardController.refreshFeedsList();
                    },
                    onLoading: () {
                      _dashBoardController.refreshFeedsList().then((value) {
                        _refreshController.loadComplete();
                      });
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _dashBoardController.getFeedsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: _dashBoardController
                                          .getFeedsList[index].userUrl!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
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
                                      placeholder: (context, url) =>
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
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
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _dashBoardController
                                              .getFeedsList[index].userName!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          DateFormat.yMMMMd().format(
                                              _dashBoardController
                                                  .getFeedsList[index].createDate!
                                                  .toDate()),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Constants().subTitleColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (_dashBoardController
                                    .getFeedsList[index].postType ==
                                    1) ...[
                                  CachedNetworkImage(
                                    imageUrl: _dashBoardController
                                        .getFeedsList[index].postUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                       Shimmer.fromColors(
                                         baseColor: Colors.grey[300]!,
                                         highlightColor: Colors.grey[100]!,
                                         enabled: true,
                                         child: Container(
                                           width: MediaQuery.of(context).size.width,
                                           height: MediaQuery.of(context).size.width,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             shape: BoxShape.rectangle,

                                           ),
                                         ),
                                       ),
                                    errorWidget: (context, url, error) =>
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          enabled: true,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              shape: BoxShape.rectangle,

                                            ),
                                          ),
                                        ),
                                  )
                                ] else ...[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: _dashBoardController
                                          .getFeedsList[index].postBgColor,
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Center(
                                      child: Text(
                                          _dashBoardController
                                              .getFeedsList[index].postText!,
                                          style: _dashBoardController.getFeedsList[index].font ==
                                              1
                                              ? GoogleFonts.rokkitt(
                                              color: _dashBoardController
                                                  .getFeedsList[index]
                                                  .postTextColor,
                                              fontSize: _dashBoardController
                                                  .getFeedsList[index]
                                                  .fontSize)
                                              : _dashBoardController.getFeedsList[index].font ==
                                              2
                                              ? GoogleFonts.specialElite(
                                              color: _dashBoardController
                                                  .getFeedsList[index]
                                                  .postTextColor,
                                              fontStyle: FontStyle.italic,
                                              fontSize: _dashBoardController
                                                  .getFeedsList[index]
                                                  .fontSize)
                                              : _dashBoardController
                                              .getFeedsList[index]
                                              .font ==
                                              3
                                              ? GoogleFonts.sofia(
                                              color: _dashBoardController
                                                  .getFeedsList[index]
                                                  .postTextColor,
                                              fontStyle:
                                              FontStyle.italic,
                                              fontSize: _dashBoardController
                                                  .getFeedsList[index]
                                                  .fontSize)
                                              : _dashBoardController.getFeedsList[index].font == 4
                                              ? GoogleFonts.sofadiOne(color: _dashBoardController.getFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: _dashBoardController.getFeedsList[index].fontSize)
                                              : _dashBoardController.getFeedsList[index].font == 5
                                              ? GoogleFonts.signika(color: _dashBoardController.getFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: _dashBoardController.getFeedsList[index].fontSize)
                                              : _dashBoardController.getFeedsList[index].font == 6
                                              ? GoogleFonts.sevillana(color: _dashBoardController.getFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: _dashBoardController.getFeedsList[index].fontSize)
                                              : GoogleFonts.rye(color: _dashBoardController.getFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: _dashBoardController.getFeedsList[index].fontSize)),
                                    ),
                                  )
                                ],
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _dashBoardController.addLikePost(
                                              _dashBoardController
                                                  .getFeedsList[index].key!,
                                              !_dashBoardController
                                                  .getFeedsList[index]
                                                  .likeModel!
                                                  .isLike!,
                                              index);
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              height: 25,
                                              "assets/icons/like.svg",
                                              color: _dashBoardController
                                                  .getFeedsList[index]
                                                  .likeModel
                                                  ?.isLike ==
                                                  true
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _dashBoardController
                                                  .getFeedsList[index]
                                                  .likeModel ==
                                                  null
                                                  ? "0"
                                                  : _dashBoardController
                                                  .getFeedsList[index]
                                                  .likeModel!
                                                  .count
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(CommentList(
                                            postId: _dashBoardController
                                                .getFeedsList[index].key));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            height: 25,
                                            "assets/icons/comment.svg",
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            _dashBoardController
                                                .getFeedsList[index]
                                                .commentCount ==
                                                null
                                                ? "0"
                                                : _dashBoardController
                                                .getFeedsList[index]
                                                .commentCount
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/share.svg",
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            )
          ],
        ));
  }
}
