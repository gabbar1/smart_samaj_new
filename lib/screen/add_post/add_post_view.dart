import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj/screen/add_post/add_biodata/add_post_controller.dart';
import '../helper/constant.dart';
import 'add_biodata/add_biodata_view.dart';
import 'add_feed_post/add_feeds_post.dart';
import 'add_job/add_job_view.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  AddPostController  addPostController = Get.put(AddPostController());
  @override
  void initState() {
    // TODO: implement initState
   // addPostController.setPostNumber =0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 20),
            child: Text(
              "Add Post",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Spacer(),
          Container(
            child: Obx(() => Column(
                  children: [
                    InkWell(
                        onTap: () {
                          addPostController.setPostNumber = 1;
                          print("==============fff=");
                          Get.to(AddFeedsPost());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          color:addPostController.getPostNumber ==1 ? Constants().subTitleColor.withOpacity(0.2):Colors.white,
                          child: Center(
                              child: Text(
                            "Create post",
                            style: TextStyle(color:addPostController.getPostNumber ==1 ? Constants().mainColor:Colors.black),
                          )),
                        )),
                    InkWell(
                        onTap: () {
                          addPostController.setPostNumber = 2;
                          Get.to(AddBioDataView());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          color:addPostController.getPostNumber ==2 ? Constants().subTitleColor.withOpacity(0.2):Colors.white,
                          child: Center(
                              child: Text(
                            "Create bio data",
                            style: TextStyle(color: addPostController.getPostNumber ==2 ? Constants().mainColor:Colors.black),
                          )),
                        )),
                    InkWell(
                        onTap: () {
                          addPostController.setPostNumber = 3;
                          Get.to(AddJobView());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          color:addPostController.getPostNumber ==3 ? Constants().subTitleColor.withOpacity(0.2):Colors.white,
                          child: Center(
                              child: Text(
                            "Add job",
                            style: TextStyle(color: addPostController.getPostNumber ==3 ? Constants().mainColor:Colors.black),
                          )),
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
