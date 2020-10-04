
import 'package:facultynoticeboard/Screens/components/showNotice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Models/notice.dart';


class NoticeList extends StatefulWidget {
  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<List<Notice>>(context) ?? [];
   // final user = Provider.of<User>(context);

        
          
          return GridView.builder (
            
          itemCount: notices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          // ignore: missing_return
          itemBuilder: (context,index){
              return ShowNotice(
              notice:notices[index]
    
            );
          }
          
          
        );
      }
        
  
    
  }

