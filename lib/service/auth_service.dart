import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:samaj/screen/tem_part/homeNavigator.dart';
import '../screen/startPage/startPage.dart';





class AuthService extends ChangeNotifier {
  AuthService();
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,spanshot){
          if(spanshot.hasData){
           // return MyHomePage(title: "",);
            return HomeNavigator();
          } else {
            return StartPage();
          }

        }
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }





}