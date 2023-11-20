import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:samaj/screen/helper/constant.dart';
import 'package:samaj/screen/jobs/job_details.dart';

import '../add_post/add_job/add_job_controller.dart';

class JobsListView extends StatefulWidget {
  const JobsListView({Key? key}) : super(key: key);

  @override
  State<JobsListView> createState() => _JobsListViewState();
}

class _JobsListViewState extends State<JobsListView> {

  AddJobController addJobController = Get.put(AddJobController());
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    // TODO: implement initState
    addJobController.fetchJobPostList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20,top: 50,right: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Jobs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

            ],),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Obx((){
              return SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: () {
                  addJobController.nextJobPostList();
                },
                onLoading: () {

                  addJobController.nextJobPostList().then((value) {
                    _refreshController.loadComplete();
                  });
                },
                child: ListView.builder(
                  itemCount: addJobController.getJobPostList.length,
                  itemBuilder: (context, index) {
                  return InkWell(onTap: (){
                    Get.to(JobDetails(jobDetails : addJobController.getJobPostList[index]));
                  },child: Container(
                    padding: EdgeInsets.only(left:20,top: 10,bottom: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(addJobController.getJobPostList[index].jobTitle.toString(),style: TextStyle(fontWeight: FontWeight.w400),),
                        SizedBox(height: 5,),
                        Row(children: [
                          SvgPicture.asset("assets/icons/location.svg"),
                          SizedBox(width: 5,),
                          Text(addJobController.getJobPostList[index].location.toString())
                        ],),
                        SizedBox(height: 5,),
                        Row(children: [
                          SvgPicture.asset("assets/icons/exp.svg"),
                          SizedBox(width: 5,),
                          Text(addJobController.getJobPostList[index].experience.toString())
                        ],),
                        SizedBox(height: 5,),
                        ReadMoreText(
                          addJobController.getJobPostList[index].description.toString(),
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
                  ),);
                },),
              );
            }),
          )
        ],
      ),
    );
  }
}
