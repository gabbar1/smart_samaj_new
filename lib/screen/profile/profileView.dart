import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:samaj/screen/helper/constant.dart';
import 'package:samaj/screen/profile/profile_list.dart';

import '../add_post/add_biodata/add_biodata_controller.dart';
import '../add_post/add_job/add_job_controller.dart';
import '../dashBoard/controller/dashboard_controller.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  DashBoardController _dashBoardController = Get.find();
  final RefreshController _feedsRefreshController = RefreshController(
    initialRefresh: false,
  );
  AddJobController addJobController = Get.put(AddJobController());
  final RefreshController _jobRefreshController = RefreshController(
    initialRefresh: false,
  );
  AddBioDataController addBioDataController = Get.put(AddBioDataController());
  final RefreshController _matrimonialRefreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    addJobController.fetchMyJobPostList();
    _dashBoardController.fetchMyFeedsList();
    addBioDataController.fetchMyMatrimonialList();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().mainColor,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: profile(),
          ),
          Expanded(
              child: DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: Constants().mainColor,
                  tabs: [
                    Tab(
                      child: Text(
                        "Feeds",
                        style: TextStyle(color: Constants().mainColor),
                      ),
                    ),
                    Tab(
                      child: Text("Jobs",
                          style: TextStyle(color: Constants().mainColor)),
                    ),
                    Tab(
                      child: Text("Matrimonial",
                          style: TextStyle(color: Constants().mainColor)),
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    feedsGridView(),
                    jobPostView(),
                    matrimonialPostView()
                  ],
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  profile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(2000.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: 'https://wallpapercave.com/dwp1x/wp1812462.jpg',
                        width: 70,
                        height: 70,
                      ))

                  ,
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: InkWell(
                        onTap: () async {
                          _showBottomSheet();
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants().mainColor),
                            child: SvgPicture.asset(
                              "assets/icons/edit_profile.svg",
                              width: 10,
                              height: 10,
                              color: Colors.white,
                            ))),
                  )
                ],
              ),
              IconButton(onPressed: (){
                Get.to(ProfileList());
              }, icon: Icon(Icons.settings,size: 40,color: Constants().mainColor,))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Abhishek Mishra",
              style: TextStyle(
                  color: Constants().subTitleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
        context: Get.context!,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text("Gallery"),
                leading: const Icon(Icons.image),
                onTap: () async {
                  _getFromGallery();
                },
              ),
              ListTile(
                title: const Text("Camera"),
                leading: const Icon(Icons.camera),
                onTap: () async {
                  _getFromCamera();
                },
              )
            ],
          );
        });
  }

  _getFromGallery() async {
    Navigator.pop(Get.context!);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    var data = await croppedFile?.readAsBytes();
    // resumeDetails.profileUpload(croppedFile!.path);
  }

  _getFromCamera() async {
    Navigator.pop(Get.context!);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Constants().mainColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      var data = await croppedFile?.readAsBytes();
      //  resumeDetails.profileUpload(croppedFile!.path);
    }
  }

  feedsGridView() {
    return Obx(() => SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _feedsRefreshController,
        onRefresh: () {
          _dashBoardController.refreshMyFeedsList();
        },
        onLoading: () {
          _dashBoardController.refreshMyFeedsList().then((value) {
            _feedsRefreshController.loadComplete();
          });
        },
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
            ),
            itemCount: _dashBoardController.getMyFeedsList.length,
            itemBuilder: (context, index) {
              if (_dashBoardController.getMyFeedsList[index].postType == 1) {
                print(
                    "==========_dashBoardController.getMyFeedsList[index].postUrl!======");
                print(_dashBoardController.getMyFeedsList[index].postUrl!);
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5,left: 5,right: 5),
                  child:CachedNetworkImage(
                    imageUrl:
                    _dashBoardController.getMyFeedsList[index].postUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5,left: 5,right: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: _dashBoardController
                          .getMyFeedsList[index].postBgColor,
                      borderRadius: BorderRadius.circular(2),
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                          _dashBoardController
                              .getMyFeedsList[index].postText!,
                          style: _dashBoardController.getMyFeedsList[index].font ==
                              1
                              ? GoogleFonts.rokkitt(
                              color: _dashBoardController
                                  .getMyFeedsList[index].postTextColor,
                              fontSize: _dashBoardController
                                  .getMyFeedsList[index].fontSize)
                              : _dashBoardController.getMyFeedsList[index].font ==
                              2
                              ? GoogleFonts.specialElite(
                              color: _dashBoardController
                                  .getMyFeedsList[index]
                                  .postTextColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 12)
                              : _dashBoardController
                              .getMyFeedsList[index].font ==
                              3
                              ? GoogleFonts.sofia(
                              color: _dashBoardController
                                  .getMyFeedsList[index]
                                  .postTextColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 12)
                              : _dashBoardController.getMyFeedsList[index].font == 4
                              ? GoogleFonts.sofadiOne(color: _dashBoardController.getMyFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: 12)
                              : _dashBoardController.getMyFeedsList[index].font == 5
                              ? GoogleFonts.signika(color: _dashBoardController.getMyFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: 12)
                              : _dashBoardController.getMyFeedsList[index].font == 6
                              ? GoogleFonts.sevillana(color: _dashBoardController.getMyFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: 12)
                              : GoogleFonts.rye(color: _dashBoardController.getMyFeedsList[index].postTextColor, fontStyle: FontStyle.italic, fontSize: 12)),
                    ),
                  ),
                );

              }
            })));
  }

  jobPostView() {
    return Obx((){
      return SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _jobRefreshController,
        onRefresh: () {
          addJobController.nextMyJobPostList();
        },
        onLoading: () {

          addJobController.nextMyJobPostList().then((value) {
            _jobRefreshController.loadComplete();
          });
        },
        child: ListView.builder(
          itemCount: addJobController.getMyJobPostList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left:20,top: 10,bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(addJobController.getMyJobPostList[index].jobTitle.toString(),style: TextStyle(fontWeight: FontWeight.w400),),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "Expire Post",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Constants().mainColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(children: [
                    SvgPicture.asset("assets/icons/location.svg"),
                    SizedBox(width: 5,),
                    Text(addJobController.getMyJobPostList[index].location.toString())
                  ],),
                  SizedBox(height: 5,),
                  Row(children: [
                    SvgPicture.asset("assets/icons/exp.svg"),
                    SizedBox(width: 5,),
                    Text(addJobController.getMyJobPostList[index].experience.toString())
                  ],),
                  SizedBox(height: 5,),
                  ReadMoreText(
                    addJobController.getMyJobPostList[index].description.toString(),
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constants().mainColor),
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Constants().mainColor),
                  ),
                  Divider(thickness: 1,)
                ],),
            );
          },),
      );
    });

  }

  matrimonialPostView() {
    return Obx((){
      return SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _matrimonialRefreshController,
        onRefresh: () {
          addBioDataController.nextMyMatrimonialList();
        },
        onLoading: () {

          addBioDataController.nextMyMatrimonialList().then((value) {
            _matrimonialRefreshController.loadComplete();
          });
        },
        child: ListView.builder(shrinkWrap: true,itemCount: addBioDataController.getMyMatrimonialList.length,itemBuilder: (context, index) {
          return
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: addBioDataController.getMyMatrimonialList[index].image_url.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width/2.3,
                          height: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.grey),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(addBioDataController.getMyMatrimonialList[index].name!+ " "+ addBioDataController.getMyMatrimonialList[index].lastName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 2,),
                          Text(addBioDataController.getMyMatrimonialList[index].occupation!,style: TextStyle(fontSize: 13,color: Constants().subTitleColor),),
                          SizedBox(height: 2,),
                          Text("Weight    -    ${addBioDataController.getMyMatrimonialList[index].weight} kg"),
                          SizedBox(height: 2,),
                          Text("height     -    ${addBioDataController.getMyMatrimonialList[index].height}"),
                          SizedBox(height: 2,),
                          Text("Age         -    ${  DateTime.now().difference(addBioDataController.getMyMatrimonialList[index].dob!.toDate()).inDays~/365} year"),
                          SizedBox(height: 2,),
                          Text(addBioDataController.getMyMatrimonialList[index].qualification!),
                          SizedBox(height: 5,),
                          Text(addBioDataController.getMyMatrimonialList[index].birthPlace!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        ],),

                    ],
                  ),

                ],),),
            );
        },),
      );
    });

  }
}
