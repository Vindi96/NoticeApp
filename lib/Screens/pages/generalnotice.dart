import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/noticeList/noticeList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Services/db.dart';
class GeneralNotice extends StatelessWidget {
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
            return NoticeService().allnotices;
          }else{
          if(userData.department=='fst'){
            return NoticeService().fstnotices;
          }else if(userData.department=='cis'){
            return NoticeService().cisnotices;
          }else if(userData.department=='pst'){
            return NoticeService().pstnotices;
          }else if(userData.department=='sport'){
            return NoticeService().sportnotices;
          }else {
            return NoticeService().nrnotices;
          }
          }
        
        }
        return StreamProvider<List<Notice>>.value(
      value: getdept(),
      child: Scaffold(
        
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
