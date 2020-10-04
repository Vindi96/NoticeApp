import 'package:facultynoticeboard/Screens/components/singlenoticeForApprove.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Models/notice.dart';


class UnApprovedNotices extends StatefulWidget {
  @override
  _UnApprovedNoticesState createState() => _UnApprovedNoticesState();
}

class _UnApprovedNoticesState extends State<UnApprovedNotices> {

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<List<Notice>>(context) ?? [];
  
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
      
        }
        
    }
      
    
  

