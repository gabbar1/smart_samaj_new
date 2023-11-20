import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:samaj/screen/helper/constant.dart';
import 'add_feed_post_controller.dart';

class AddFeedsPost extends StatefulWidget {
  const AddFeedsPost({Key? key}) : super(key: key);

  @override
  State<AddFeedsPost> createState() => _AddFeedsPostState();
}

class _AddFeedsPostState extends State<AddFeedsPost> {
  Offset offset = Offset.zero;

  TextEditingController controller = TextEditingController();
  bool isVisible = true;
  bool isVisibleText = true;
  bool isTextColorChange = false;
  Color selectedColor = Colors.black;
  Color backgroundColor = Constants().mainColor;
  AddFeedPostController addFeedPostController = Get.put(AddFeedPostController());
  double fontSize =30.0;
  int font = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Obx(() {
                      if (addFeedPostController.getProfilePictures == "") {
                        return Container(
                          color: backgroundColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                        );
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(addFeedPostController
                                      .getProfilePictures)),
                                  fit: BoxFit.fill)),
                        );
                      }
                    }),

                      if(isVisibleText)...[
                        Center(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: font == 1
                                ? GoogleFonts.rokkitt(
                                color: selectedColor, fontSize: fontSize)
                                : font == 2
                                ? GoogleFonts.specialElite(
                                color: selectedColor,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSize)
                                : font == 3
                                ? GoogleFonts.sofia(
                                color: selectedColor,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSize)
                                : font == 4
                                ? GoogleFonts.sofadiOne(
                                color: selectedColor,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSize)
                                : font == 5
                                ? GoogleFonts.signika(
                                color: selectedColor,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSize)
                                : font == 6
                                ? GoogleFonts.sevillana(
                                color: selectedColor,
                                fontStyle:
                                FontStyle.italic,
                                fontSize: fontSize)
                                : GoogleFonts.rye(
                                color: selectedColor,
                                fontStyle:
                                FontStyle.italic,
                                fontSize: fontSize),
                            //  focusNode: _focusNode,
                            maxLines: null,
                            onChanged: (val) {
                              setState(() {
                                //  isVisible = false;
                                //  isTextColorChange = true;
                              });
                            },
                            controller: controller,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "enter text",
                              hintStyle: TextStyle(color: selectedColor,fontSize: fontSize),

                            ),
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "tr('field_required')";
                                //"Please enter valid floor number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ]

                  ],
                ),
              ),
              isVisible
                  ? Positioned(
                      left: 0,
                      top: 20,
                      width: MediaQuery.of(context).size.width ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisibleText =!isVisibleText;
                                addFeedPostController.setProfilePictures = "";
                               // isVisible = !isVisible;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants().mainColor,
                              ),
                              child: isVisibleText?Text(
                                "A",
                                style: TextStyle(color: Colors.white),
                              ):Icon(Icons.cancel),
                            ),
                          ),
                         isVisibleText ?Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                                color:
                                 Constants().mainColor.withOpacity(.8),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor = Color(0xFF32FF9D);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF32FF9D)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor = Color(0xFFFF776B);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFF776B)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor = Color(0xFF45C5FF);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF45C5FF)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor = Color(0xFFB0D16F);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFB0D16F)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor =  Color(0xFFFFBE63);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFFBE63)),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      backgroundColor = Color(0xFFF71E78);
                                      addFeedPostController.setProfilePictures = "";
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF71E78)),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      20,
                                )
                              ],
                            ),
                          ):Container( margin: EdgeInsets.only(
                           left: 10,
                           right: 10,
                         ),
                           height: 55,
                           width: MediaQuery.of(context).size.width/1.5,),
                       isVisibleText == true?   GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: OColorPicker(
                                        selectedColor: selectedColor,
                                        colors: primaryColorsPalette,
                                        onColorChange: (color) {
                                          setState(() {
                                            selectedColor = color;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedColor,
                              ),
                              child: Text(
                                "T",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ):Container(
                         alignment: Alignment.center,
                         height: 40,
                         width: 40,

                       ),

                          SizedBox(width: 20,)
                        ],
                      ))
                  : Container(),
              isVisibleText
                  ? Positioned(
                  top: 150,
                  right: MediaQuery.of(context).size.width / 1.45,

                  child: Transform(
                    alignment: FractionalOffset.center,
                    // Rotate sliders by 90 degrees
                    transform: new Matrix4.identity()
                      ..rotateZ(270 * 3.1415927 / 180),
                    child: Slider(
                      value: fontSize,
                      onChanged: (double size) {
                        setState(() {
                          fontSize = size;
                        });
                      },
                      divisions: 10,
                      min: 10,
                      max: 60.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                    ),
                  ))
                  : Container(),

            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 55,
                    padding: EdgeInsets.only(left: 10,right: 10),

                    child: Row(
                      children: [

                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 1;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/rokkit_text_1.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 1;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/special_elite_text_2.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 2;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/sofia_text_3.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 3;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/sofadi_one_4.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 4;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/signatra_demo_text_5.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              font = 5;
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/sevillana_text_6.svg")),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                             
                              font = 6;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Constants().mainColor,
                              child: SvgPicture.asset(
                                  "assets/icons/rye_text_7.svg")),
                        ),

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisibleText=false;
                    });
                    showImagePicker();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage("assets/icons/photo.png"))),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: (){
              if(isVisibleText==true) {
                Get.to(FinalPost(isTextPost: isVisibleText,
                  bgColor: backgroundColor,
                  text: controller.text,
                  fontSize: fontSize,
                  font: font,
                  selectedColor: selectedColor,));
              }else{
                Get.to(FinalPost(isTextPost: false,));
              }
            },
            child: Container(
              height: 65,
              width: 200,
              decoration: BoxDecoration(
                  color: Constants().mainColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next",style: TextStyle(fontSize: 22,color: Colors.white),),
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_forward_ios,size: 30,color: Colors.white,)
                ],),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  void showImagePicker() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(Get.context!).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final imagePicker = ImagePicker();
  _imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      //  maxWidth: 1024,
       // maxHeight: 1024
    );
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Adjust Image",
            toolbarColor: Constants().mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(minimumAspectRatio: 1.0)
      ],
    );
    addFeedPostController.setProfilePictures = croppedFile!.path;
  }

  _imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
       /// maxWidth: 1024,
       // maxHeight: 1024
    );
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Adjust Image",
            toolbarColor: Constants().mainColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(minimumAspectRatio: 1.0)
      ],
    );

    addFeedPostController.setProfilePictures = croppedFile!.path;
  }
}

class FinalPost extends StatefulWidget {
   FinalPost({this.isTextPost,this.text,this.bgColor,this.font,this.fontSize,this.selectedColor});
   bool? isTextPost;
   String? text;
   Color? bgColor;
   int? font;
   double? fontSize;
   Color? selectedColor;
  @override
  State<FinalPost> createState() => _FinalPostState();
}

class _FinalPostState extends State<FinalPost> {
  AddFeedPostController addFeedPostController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post")),
      body: Column(
        children: [
          if(widget.isTextPost==true)...[
            Container(
              color: widget.bgColor!,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Center(child: Text(widget.text!,style:widget.font == 1
                  ? GoogleFonts.rokkitt(
                  color: widget.selectedColor, fontSize: widget.fontSize)
                  : widget.font == 2
                  ? GoogleFonts.specialElite(
                  color: widget.selectedColor,
                  fontStyle: FontStyle.italic,
                  fontSize: widget.fontSize)
                  : widget.font == 3
                  ? GoogleFonts.sofia(
                  color: widget.selectedColor,
                  fontStyle: FontStyle.italic,
                  fontSize: widget.fontSize)
                  : widget.font == 4
                  ? GoogleFonts.sofadiOne(
                  color: widget.selectedColor,
                  fontStyle: FontStyle.italic,
                  fontSize: widget.fontSize)
                  : widget.font == 5
                  ? GoogleFonts.signika(
                  color: widget.selectedColor,
                  fontStyle: FontStyle.italic,
                  fontSize: widget.fontSize)
                  : widget.font == 6
                  ? GoogleFonts.sevillana(
                  color: widget.selectedColor,
                  fontStyle:
                  FontStyle.italic,
                  fontSize: widget.fontSize)
                  : GoogleFonts.rye(
                  color: widget.selectedColor,
                  fontStyle:
                  FontStyle.italic,
                  fontSize: widget.fontSize)),),
            ),
          ],
          if(widget.isTextPost==false)...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(addFeedPostController
                          .getProfilePictures)),
                      fit: BoxFit.fill)),
            )
          ],
          Spacer(),
          InkWell(
            onTap: (){
              if(widget.isTextPost==false) {
                addFeedPostController.uploadImagePost();
              }else{
                addFeedPostController.uploadTextPost(fontSize: widget.fontSize,font: widget.font,postBgColor: widget.bgColor,postText: widget.text,postTextColor: widget.selectedColor);
              }


            },
            child: Container(
              height: 65,
              width: 200,
              decoration: BoxDecoration(
                  color: Constants().mainColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Post",style: TextStyle(fontSize: 22,color: Colors.white),),
                SizedBox(width: 10,),
                Icon(Icons.arrow_forward_ios,size: 30,color: Colors.white,)
              ],),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

