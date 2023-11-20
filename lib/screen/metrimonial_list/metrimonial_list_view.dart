import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../add_post/add_biodata/add_biodata_controller.dart';
import '../helper/constant.dart';
import 'matrimonial_details.dart';

class MetrimonialView extends StatefulWidget {
  const MetrimonialView({Key? key}) : super(key: key);

  @override
  State<MetrimonialView> createState() => _MetrimonialViewState();
}

class _MetrimonialViewState extends State<MetrimonialView> {
  AddBioDataController addBioDataController = Get.put(AddBioDataController());
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    // TODO: implement initState
    addBioDataController.fetchMatrimonialList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, bottom: 20, right: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Matrimonial List",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Female"),
                            Container(
                              height: 2,
                              width: 25,
                              color: Constants().mainColor,
                            )
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            Text("Male"),
                            Container(
                              height: 2,
                              width: 25,
                              color: Constants().mainColor,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    cursorColor: Constants().mainColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Constants().subTitleColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Constants().subTitleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx((){
              return SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: () {
                  addBioDataController.nextMatrimonialList();
                },
                onLoading: () {

                  addBioDataController.nextMatrimonialList().then((value) {
                    _refreshController.loadComplete();
                  });
                },
                child: ListView.builder(shrinkWrap: true,itemCount: addBioDataController.getMatrimonialList.length,itemBuilder: (context, index) {
                  return
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: InkWell(
                        onTap: (){
                          Get.to(MatrimonialDetails(matrimonialDetails: addBioDataController.getMatrimonialList[index],));
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: addBioDataController.getMatrimonialList[index].image_url.toString(),
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
                                    Text(addBioDataController.getMatrimonialList[index].name!+ " "+ addBioDataController.getMatrimonialList[index].lastName!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2,),
                                    Text(addBioDataController.getMatrimonialList[index].occupation!,style: TextStyle(fontSize: 13,color: Constants().subTitleColor),),
                                    SizedBox(height: 2,),
                                    Text("Weight    -    ${addBioDataController.getMatrimonialList[index].weight} kg"),
                                    SizedBox(height: 2,),
                                    Text("height     -    ${addBioDataController.getMatrimonialList[index].height}"),
                                    SizedBox(height: 2,),
                                    Text("Age         -    ${  DateTime.now().difference(addBioDataController.getMatrimonialList[index].dob!.toDate()).inDays~/365} year"),
                                    SizedBox(height: 2,),
                                    Text(addBioDataController.getMatrimonialList[index].qualification!),
                                    SizedBox(height: 5,),
                                    Text(addBioDataController.getMatrimonialList[index].birthPlace!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],),

                              ],
                            ),

                          ],),),
                      ),
                    );
                },),
              );
            }),
          )
        ],
      ),
    );
  }
}
