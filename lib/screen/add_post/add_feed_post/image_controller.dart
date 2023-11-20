import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
class ImageController extends GetxController{


  List<String> type = <String>[];
  String? imageLink,filename;

  List result = [];
  Uint8List? pngBytes ;
  File? capturedFile;
  File? capturedNewFile;



  Future<void> shareScreenshot(
      GlobalKey _globalKey,
      ) async {
    try {
      //extract bytes
      final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      String dir = (await getApplicationDocumentsDirectory()).path;
      final String fullPath = '$dir/${DateTime.now().millisecond}.png';
      capturedFile = File(fullPath);
      await capturedFile!.writeAsBytes(byteData.buffer.asUint8List());

      capturedFile = File(fullPath);

      final cropImage = decodeImage(File(fullPath).readAsBytesSync());

    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    final thumbnail = copyResize(cropImage!, width: 300,height:300,interpolation: Interpolation.average);


    // Save the thumbnail as a PNG.
    final String newFullPath = '$dir/${DateTime.now().millisecond}.png';
    File(newFullPath).writeAsBytesSync(encodePng(thumbnail));
    capturedNewFile = File(newFullPath);
    filename=newFullPath.split("/").last;


    } catch (e) {
    print("Share Screenshot Error :: " + e.toString());
    }
  }

}