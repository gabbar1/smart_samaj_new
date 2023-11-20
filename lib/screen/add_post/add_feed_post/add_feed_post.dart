import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as container;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:screenshot/screenshot.dart';

import 'image_controller.dart';

class AddFeedView extends StatefulWidget {
  @override
  _AddFeedViewState createState() => _AddFeedViewState();
}

class _AddFeedViewState extends State<AddFeedView> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> addPostFormKey = new GlobalKey<FormState>();



  String? uid;
  bool text = true;
  bool textHide = false;
  bool image = false;
  bool imageHide = false;
  bool video = false;
  bool gif = false;
  Color back = Color(0xFF313131);
  Offset offset = Offset.zero;
  bool isVisible = true;
  int font = 1;
  double fontSize = 20;
  String hint = "type gaali";
  bool isTextColorChange = false;
  Color selectedColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.uid = '';
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    this.uid = user!.uid;
  }

  ScreenshotController screenshotController = ScreenshotController();
  ScreenshotController imageController = ScreenshotController();
  GlobalKey scafoldKey = GlobalKey();
  GlobalKey imagekey = GlobalKey();
  ImageController _controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {

      return SafeArea(child:Scaffold(
          backgroundColor: Color(0xFF232027),
          body: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                imageHide = false;
                textHide = false;
                isVisible = true;
                isTextColorChange = false;
              });
            },
            child: RepaintBoundary(
              child: Screenshot(
                key: scafoldKey,
                controller: screenshotController,
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      RepaintBoundary(
                        child: Screenshot(
                          key: imagekey,
                          controller: imageController,
                          child: Stack(children: [container.Container(
                              color: _controller.imageLink == null ? back : null,
                              height: MediaQuery.of(context).size.height,
                              decoration: _controller.imageLink != null
                                  ? _controller.imageLink!.contains("https")
                                  ? BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_controller.imageLink!),
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                                  : BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  FileImage(File(_controller.imageLink!)),
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : null),

                            Positioned(
                              left: offset.dx,
                              top: offset.dy,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  setState(() {
                                    offset = Offset(offset.dx + details.delta.dx,
                                        offset.dy + details.delta.dy);
                                  });
                                },
                                child: container.Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height / 3,
                                      left: 50,
                                      right: 50),
                                  // height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Scrollbar(
                                    child: TextFormField(
                                      //  focusNode: _focusNode,
                                      maxLines: null,
                                      onChanged: (val) {
                                        setState(() {
                                          isVisible = false;
                                          isTextColorChange = true;
                                        });
                                      },
                                      controller: controller,
                                      /*style: font == 1
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
                                          fontSize: fontSize)*/
                                      decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: hint,
                                          hintStyle: TextStyle(color: Colors.white)),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "tr('field_required')";
                                          //"Please enter valid floor number";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),],),
                        ),
                      ),
                      isVisible
                          ? Positioned(
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                                hint = "";
                              });
                              FocusScope.of(context).unfocus();
                              Future.delayed(Duration(seconds: 1), () {
                                _controller.shareScreenshot(_controller.imageLink != null ? imagekey : scafoldKey)
                                    .then((val) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditImage(
                                          text: controller.text,
                                        )),
                                  );
                                });
                              });
                            },
                            child: Center(
                              child: container.Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      bottom: 25,
                                      left: 130,
                                      right: 130,
                                      top: MediaQuery.of(context).size.height -
                                          150),
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF5458F7),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )),
                            ),
                          ))
                          : Container(),
                      isVisible
                          ? Positioned(
                        right: 20,
                        child: container.Container(
                            margin: EdgeInsets.only(
                                bottom: 25,


                                top: 45),
                            height: MediaQuery.of(context).size.height / 3,
                            child: container.Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      textHide = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                    });
                                  },
                                  child: textHide == false
                                      ? SvgPicture.asset("assets/icons/text.svg")
                                      : SvgPicture.asset(
                                    "assets/icons/text.svg",
                                    color: Colors.transparent,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = false;
                                      video = false;
                                      image = true;
                                      imageHide = true;
                                      gif = false;
                                    });
                                  },
                                  child: imageHide == false
                                      ? SvgPicture.asset("assets/icons/color.svg")
                                      : SvgPicture.asset(
                                    "assets/icons/color.svg",
                                    color: Colors.transparent,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GaliImagesView()),
                                    );*/
                                    setState(() {
                                      text = false;
                                      video = true;
                                      image = false;
                                      gif = false;
                                    });
                                  },
                                  child: Image.asset("assets/icons/icon.png"),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = false;
                                      video = false;
                                      image = false;
                                      gif = true;
                                    });
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GaliLibView()),
                                    );*/
                                  },
                                  child:
                                  SvgPicture.asset("assets/icons/gaaliya.svg"),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 20,
                                )
                              ],
                            )),
                      )
                          : Container(),

                      isVisible
                          ? Positioned(
                          top: MediaQuery.of(context).size.height / 11,
                          width: MediaQuery.of(context).size.width,
                          child: textHide != false
                              ? container.Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            height: 55,
                            decoration: BoxDecoration(
                                color:
                                const Color(0xFF000000).withOpacity(.5),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      font = 1;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_one.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 1;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_two.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 2;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_three.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 3;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_four.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 4;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_five.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 5;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_six.png")),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      text = true;
                                      video = false;
                                      image = false;
                                      gif = false;
                                      font = 6;
                                    });
                                  },
                                  child: Center(
                                      child: Image.asset(
                                          "assets/icons/text_seven.png")),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      10,
                                )
                              ],
                            ),
                          )
                              : container.Container(
                            height: 55,
                          ))
                          : Container(),
                      isVisible
                          ? Positioned(
                          top: 100,
                          right: MediaQuery.of(context).size.width / 1.4,
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
                ),
              ),
            ),
          )),);

  }
}

class EditImage extends StatefulWidget {
  String? text;
  EditImage({this.text});
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.uid = '';
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    this.uid = user!.uid;
  }
  ImageController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF232027),
      //We are cresting post component here
      body: Stack(
            children: [
              container.Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: _controller.pngBytes == null
                      ? _controller.imageLink != null
                      ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_controller.imageLink!),
                      fit: BoxFit.fitWidth,
                    ),
                  )
                      : null
                      : BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_controller.capturedNewFile!),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Center(
                      child: container.Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: 25,
                              left: 130,
                              right: 130,
                              top: MediaQuery.of(context).size.height - 100),
                          height: 55,
                          decoration: BoxDecoration(
                              color: Color(0xFF5458F7),
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                          child: Container(
                            child: Center(
                                child: Text(
                                  "Post",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )),
                    ),
                  ))
            ],
          )

    ));
  }
}