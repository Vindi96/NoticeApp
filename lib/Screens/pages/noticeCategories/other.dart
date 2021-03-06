import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/noticeList/noticeList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Services/db.dart';
class ViewotherNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
       stream:UserService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
        User userData=snapshot.data;
        Stream getdept(){
            if(userData.department=='all'){
            return NoticeService().allothers;
          }else{
          if(userData.department=='fst'){
            return NoticeService().fstothers;
          }else if(userData.department=='cis'){
            return NoticeService().cisothers;
          }else if(userData.department=='pst'){
            return NoticeService().pstothers;
          }else if(userData.department=='sport'){
            return NoticeService().sportothers;
          }else {
            return NoticeService().nrothers;
          }
          }
        
        }
        return StreamProvider<List<Notice>>.value(
      value: getdept(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
         title: Text('Notices',
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
      body:NoticeList() ,

      ),
      
    );
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');

        }
        return CircularProgressIndicator();
      });
      
    
  }
}
