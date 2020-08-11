import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Screens/components/showNotice.dart';
import 'package:facultynoticeboard/Screens/components/singlenoticeForApprove.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Services/db.dart';

class UnApprovedNotices extends StatefulWidget {
  @override
  _UnApprovedNoticesState createState() => _UnApprovedNoticesState();
}

class _UnApprovedNoticesState extends State<UnApprovedNotices> {

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<List<Notice>>(context) ?? [];
    final user = Provider.of<User>(context);
    return StreamBuilder(
      stream:UserService(uid: user.uid).userData,
      builder: (context,snapshot){
        User userData=snapshot.data;
        
        return StreamBuilder<List<Notice>>(
      stream: NoticeService().notices,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          
          return GridView.builder (
            
          itemCount: notices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          // ignore: missing_return
          itemBuilder: (context,index){
              return SingleNotice(
              notice:notices[index]
    
            );
          }
          
          
        );
      }else{
        return(Text('No List'));
      }
        }
        
    );}
      );
    
  }
}
