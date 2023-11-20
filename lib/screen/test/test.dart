import 'package:flutter/material.dart';
import 'package:samaj/screen/test/home.dart';

class Login extends StatefulWidget {
   Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool _passwordVisible = true;
 /* @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = true;
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("login"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Text(
              "welcome to login page",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                  hintText: "passwod",
                 suffixIcon:IconButton(onPressed: (){
                   setState(() {
                     _passwordVisible = !_passwordVisible;
                   });
                 },
                   icon:
                   _passwordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HomePage(email: emailController.text,password: passwordController.text,name: nameController.text))));
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink),
                  height: 50,
                  width: 250,
                  child: Center(
                    child: Text("submit", style: TextStyle(fontSize: 20)),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
