
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/noticedetails.dart';
import 'package:facultynoticeboard/Services/db.dart';
import 'package:flutter/material.dart';
class SingleNotice extends StatelessWidget {
 final Notice notice;
  SingleNotice({
    this.notice
  });
  final NoticeService noticeServices=NoticeService();
  
  @override
  Widget build(BuildContext context) {
   DateTime uploadedDateTime=notice.dateTime;
        return Card(
          child: Hero(
            tag: notice.title,
            child:Material(
              child:InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>NoticeDetails(
                      noticeDetailTitle: notice.title,
                      //noticeDetailDate: notice.date,
                      noticeDetailImage: notice.url,
                    )));
                },
                child: GridTile(
                  child: Image.network(notice.url,fit: BoxFit.cover,),
                  footer: Container(
                    color: Colors.white70,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(notice.title,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text('${uploadedDateTime.day}/${uploadedDateTime.month}/${uploadedDateTime.year}  (${uploadedDateTime.hour}:${uploadedDateTime.minute}:${uploadedDateTime.second})',),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text(
                              notice.category,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                                ),
                                ),
                                SizedBox(width: 150,),
                                IconButton(
                                  icon: Icon(Icons.check,color: Colors.green,),
                                  onPressed: (){
                                   dialogTrigger(context, notice.noticeId);

                                  },
                                ),
                                // SizedBox(width: 20,),
                                IconButton(
                                  icon: Icon(Icons.delete,color: Colors.red,),
                                  onPressed:() {deleteDialog(context, notice.noticeId);}
                                ),
                          ],
                        )
                      ],
                    ),
                    ),
                  ),
              )
            ),
          ),
          
        );
     
  }
  Future<bool>dialogTrigger(BuildContext context,selectedDoc)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Do you want to approve the notice?'),
          actions: <Widget>[
            FlatButton(
              child: Text('yes'),
              textColor: Colors.blue,
              onPressed: (){
                noticeServices.updateData(selectedDoc,{'status':'approved'});
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
   Future<bool>deleteDialog(BuildContext context,docId)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are you sure, you want delete notice?'),
          actions: <Widget>[
            FlatButton(
              child: Text('yes'),
              textColor: Colors.blue,
              onPressed: (){
                noticeServices.deleteData(docId);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
}

