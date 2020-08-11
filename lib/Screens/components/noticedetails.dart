import 'package:flutter/material.dart';

class NoticeDetails extends StatefulWidget {
  final noticeDetailTitle;
  final noticeDetailImage;
 // final noticeDetailDate;

  NoticeDetails({
    this.noticeDetailTitle,
   // this.noticeDetailDate,
    this.noticeDetailImage

  });
  @override
  _NoticeDetailsState createState() => _NoticeDetailsState();
}

class _NoticeDetailsState extends State<NoticeDetails> {
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
         title: Text('Notices App',
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
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: GridTile(
              child: Container(
                height: 350,
                color: Colors.white70,
                child: Image.network(widget.noticeDetailImage, fit: BoxFit.cover,),
              ),
            ),
          ),
          Container(
             child: ListTile(
                  title: Text(widget.noticeDetailTitle,style: TextStyle(fontWeight: FontWeight.bold),),
                  //subtitle: Text(widget.noticeDetailDate),
                ),

          )
        ],
      ),
      
    );
  }
}