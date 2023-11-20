import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
   HomePage({this.email , this.password,this.name});
   String? email;
   String? password;
   String? name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.email.toString()),
            SizedBox(
              height: 20,
            ),
            Text(widget.password.toString()),
            SizedBox(
              height: 20,
            ),
            Text(""),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (){},
                child: Icon(Icons.add))

          ],
        ),
      ),
    );
  }
}
