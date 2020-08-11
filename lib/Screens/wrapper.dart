
import 'package:facultynoticeboard/Screens/authenticate/authenticate.dart';
import 'package:facultynoticeboard/Screens/pages/Dean/homePage.dart';
import 'package:facultynoticeboard/Screens/pages/HOD/homePage.dart';
import 'package:facultynoticeboard/Screens/pages/Lecture/homePage.dart';
import 'package:facultynoticeboard/Screens/pages/Student/homePage.dart';
import 'package:facultynoticeboard/Services/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Models/model.dart';

class WrapperPage extends StatefulWidget {
  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
   final user = Provider.of<User>(context);

   // print(user);
   if(user!=null){
     return StreamBuilder<User>(
      stream: UserService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          User userData=snapshot.data;
          if(userData.category=='HOD'){
            return HodHomePage();
          }else if(userData.category=='Dean'){
            return DeanHomePage();
          }else if(userData.category=='Lecture'){
            return LectureHomePage();
          }else{
            return StudentHomePage();
          }

        }else{
          return Text('loading');
        }
      }
      
    );
   }else{
     return Authenticate();

   }
   
   
  }
  
}