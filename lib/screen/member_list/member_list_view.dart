import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/constant.dart';
class MemberListView extends StatefulWidget {
  const MemberListView({Key? key}) : super(key: key);

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, bottom: 20,right: 20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Member List",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   SizedBox(height: 10,),
                   SizedBox(
                     height: 40,
                     child: TextFormField(
                     cursorColor: Constants().mainColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon:Icon(Icons.search_sharp,color: Colors.black,) ,
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
            SizedBox(height: 5,),
            Expanded(
              child: ListView.builder(shrinkWrap: true,itemCount: 20,itemBuilder: (context, index) {
                return
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(

                              children: [
                                CachedNetworkImage(
                                  imageUrl: 'https://scontent.famd15-1.fna.fbcdn.net/v/t1.6435-9/89343025_2558690311015782_7460875728121233408_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=UWi0Kr5O4lIAX-hszqs&_nc_ht=scontent.famd15-1.fna&oh=00_AfB3JkysG7dDYhefFzniKpHgZAWhLLf3hLTed5hfBILnFQ&oe=63CEB84C',
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                    Text("Mandar Smart",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 2,),
                                    Text("+91 9825958877",style: TextStyle(fontSize: 13,color: Constants().subTitleColor),),
                                  ],),
                              ],
                            ),
                             Padding(
                               padding: const EdgeInsets.only(right: 20,top: 10),
                               child: SvgPicture.asset("assets/icons/phone.svg",height: 20),
                             ),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 1,),
                        SizedBox(height: 10,),
                         SizedBox(
                           height: MediaQuery.of(context).size.width/3,
                           child: ListView.builder(
                             
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                            return Card(child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                              child: Column(children: [
                                CachedNetworkImage(
                                  imageUrl: 'https://scontent-bom1-1.xx.fbcdn.net/v/t39.30808-6/313249694_10160151439328544_2219473593054676171_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=e3f864&_nc_ohc=jho_44PWp3gAX-Xttsp&_nc_ht=scontent-bom1-1.xx&oh=00_AfCnCjRqeuSPKrDfRHMpyFCBKFWy2MYD8o1oGJR04WgJ_w&oe=63ACD5E2',
                                  imageBuilder: (context, imageProvider) => Container(
                                    
                                    width: MediaQuery.of(context).size.width/5,
                                    height: MediaQuery.of(context).size.width/5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                SizedBox(height: 10,),
                                Text("Hasti Smart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                                Text("Wife",style: TextStyle(color: Constants().subTitleColor,fontSize: 8),),

                              ],),
                            ),);
                        },),
                         ),

                      ],),),
                  );
              },),
            )
          ],
        )
    );
  }
}
