import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/unapprovednotices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Services/db.dart';
class AproveNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
       title: Text('Aprove Notices',
       style: TextStyle(
         fontFamily: 'Montserrat',
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       ),
       backgroundColor: Colors.blue[800],
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.search, color: Colors.white,), 
           onPressed: (){}
           ),
           
       ], 
      ),
      
    
    body:UnApprovedNotices() ,

    );
  }
}