import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Screens/authenticate/regester.dart';
import 'package:facultynoticeboard/Screens/authenticate/sign_in.dart';
import 'package:facultynoticeboard/Screens/pages/HOD/homePage.dart';
import 'package:facultynoticeboard/Screens/pages/aprovenotice.dart';
import 'package:facultynoticeboard/Screens/pages/noticeCategories/exam.dart';
import 'package:facultynoticeboard/Screens/pages/seenotices.dart';
import 'package:facultynoticeboard/Screens/pages/userprofile.dart';
import 'package:facultynoticeboard/Services/auth.dart';
import 'package:flutter/material.dart';
import 'Screens/pages/Dean/homePage.dart';
import 'Screens/pages/Lecture/homePage.dart';
import 'Screens/pages/Student/homePage.dart';
import 'Screens/pages/noticeCategories/mahapola.dart';
import 'Screens/pages/noticeCategories/other.dart';
import 'Screens/pages/noticeCategories/result.dart';
import 'Screens/pages/noticeCategories/timetable.dart';
import 'Screens/pages/viewNotices.dart';
import 'Screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'Screens/pages/uploadNotice.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WrapperPage(),
         routes: <String, WidgetBuilder>{
          
          '/login': (BuildContext context) => new SignIn(),
          '/signup': (BuildContext context) => new Regester(),
          '/DeanHome':(BuildContext context)=>new DeanHomePage(),
          '/LectureHome':(BuildContext context)=>new LectureHomePage(),
          '/StudentHome':(BuildContext context)=>new StudentHomePage(),
          '/Upload Notices':(BuildContext context)=>new UploadNotice(),
          '/Approve Notice':(BuildContext context)=>new AproveNotice(),
          '/My Account':(BuildContext context)=>new ProfilePage(),
          '/HODHome':(BuildContext context)=>new HodHomePage(),
          '/View Notices':(BuildContext context)=>new ViewNotice(),
          '/SeeNotices':(BuildContext context)=> new SeeNotices(),
          '/Exams': (BuildContext context)=> new ViewExamNotice(),
          '/Mahapola/busary': (BuildContext context)=> new ViewmbNotice(),
          '/Time Tables': (BuildContext context)=> new ViewTimetableNotice(),
          '/Results':(BuildContext context)=> new ViewResultNotice(),
          '/Other':(BuildContext context)=> new ViewotherNotice(),
         
          
        },
      ),
    );
  }
}


