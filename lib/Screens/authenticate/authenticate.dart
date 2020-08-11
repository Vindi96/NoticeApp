import 'package:facultynoticeboard/Screens/authenticate/regester.dart';
import 'package:facultynoticeboard/Screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleview(){
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleview: toggleview);
    }else{
      return Regester(toggleview: toggleview);
    }
  }
}