import 'package:flutter/material.dart';
class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Container(
        height: 50.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Departments(deptname: 'CIS',color: Colors.blue,),
            Departments(deptname: 'NR',color: Colors.green,),
            Departments(deptname: 'FST',color: Colors.orange,),
            Departments(deptname: 'PST',color: Colors.pink,),
            Departments(deptname: 'Sport',color: Colors.purple,),
            Departments(deptname: 'General',)
            
          ],
        ),
        
      ),
    );
  }
}
class Departments extends StatelessWidget {
  final String deptname;
  final Color color;
  Departments({this.deptname,this.color});

  @override
  Widget build(BuildContext context) {
    void navigateTo(){
     Navigator.of(context).pushNamed('/Approve Notice');
   }
    return Padding(
     padding: const EdgeInsets.all(2.0),
     child: SizedBox(
         child: RaisedButton(
         onPressed: (){navigateTo();},
         child: Text(deptname),
         color:color,
         ),
     ), 
    );
  }
}