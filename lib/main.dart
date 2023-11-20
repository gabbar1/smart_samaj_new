import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:samaj/firebase_options.dart';
import 'package:samaj/screen/tem_part/controller/family_group_controller.dart';
import 'screen/helper/constant.dart';
import 'screen/register/registerController.dart';
import 'screen/tem_part/controller/addController.dart';
import 'screen/updateScreen/forceUpdate.dart';
import 'package:get/get.dart';
import 'service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(RegisterController());
  Get.put(AddController());
  FamilyGroupController familyGroupController = Get.put(FamilyGroupController());
  familyGroupController.fetchAdminList();


  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Constants().mainColor),
    home: MyApp(),
   // home: Login(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging? firebaseMessaging;



  var version = 1;

  @override
  void initState() {
    super.initState();
    print("_____________checkVersion-----------------");
    FirebaseFirestore.instance
        .collection("version")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (version == element["version"]) {
          print("--------latestVersion----------");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthService().handleAuth()),
                  (route) => false);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ForceUpdateView(
                          element["update"].toString(),
                          element['force'].toString(),
                          element['maintance'].toString())));
        }
      });
    });



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("--------------listen");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(child: Image.asset("assets/icons/icon.png"),),
      ),
    );
  }
}
