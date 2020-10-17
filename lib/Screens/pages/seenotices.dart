import 'package:flutter/material.dart';

class SeeNotices extends StatefulWidget {
  @override
  _SeeNoticesState createState() => _SeeNoticesState();
}

class _SeeNoticesState extends State<SeeNotices> {
    Expanded buildKey({String name}){
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(18.0),
           side: BorderSide(color: Colors.blueGrey[300])
        ),
        child: Text('$name'),
        color: Colors.blueGrey[300],
        onPressed: (){
         Navigator.of(context).pushNamed('/$name');
        },
      ),
          
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Notices'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        margin:EdgeInsets.all(30.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                buildKey(name:'Exams'),
                SizedBox(height:20),
                buildKey(name:'Mahapola/busary'),
                SizedBox(height:20),
                buildKey(name:'Results'),
                SizedBox(height:20),
                buildKey(name:'Time Tables'),
                SizedBox(height:20),
                buildKey(name:'Other'),
           
          ],
        ),
      ),
      
    );
  }
}