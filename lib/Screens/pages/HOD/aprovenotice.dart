import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/unapprovednotices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Services/db.dart';
class AproveNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
       stream:UserService(uid: user.uid).userData,
      builder: (context,snapshot){
        User userData=snapshot.data;
        Stream getdept(){
            if(userData.department=='All'){
            return NoticeService().unapprovedgeneralnotices;
          }else{
          if(userData.department=='fst'){
            return NoticeService().unapprovedfstnotices;
          }else if(userData.department=='cis'){
            return NoticeService().unapprovedcisnotices;
          }else if(userData.department=='pst'){
            return NoticeService().unapprovedpstnotices;
          }else if(userData.department=='sport'){
            return NoticeService().unapprovedsportnotices;
          }else {
            return NoticeService().unapprovednrnotices;
          }
          }

        }
     return StreamProvider<List<Notice>>.value(
      value: getdept(), 
      child: Scaffold(
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

    )
    );
    }
    );
  }
}