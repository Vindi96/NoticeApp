import 'package:carousel_pro/carousel_pro.dart';
import 'package:facultynoticeboard/Screens/components/Drawers/hodDrawer.dart';
import 'package:facultynoticeboard/Screens/components/horisontal_listview.dart';


import 'package:flutter/material.dart';

import '../generalnotice.dart';

class HodHomePage extends StatefulWidget {
  @override
  _HodHomePageState createState() => _HodHomePageState();
}

class _HodHomePageState extends State<HodHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel=Container(
       height: 200.0,
       child: Carousel(
         boxFit: BoxFit.cover,
         images: [
           AssetImage('images/1.jpeg'),
           AssetImage('images/2.jpg'),
           AssetImage('images/3.jpg'),
           AssetImage('images/4.png'),
           AssetImage('images/5.jpg'),
         ],
         dotSize: 4.0,
         autoplay: true,
         animationCurve: Curves.fastOutSlowIn,
         animationDuration: Duration(microseconds: 1000),
         indicatorBgPadding: 6.0,
       ),
     );
    
    
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
      drawer:HODDrawerpart(),
      body: ListView(
        children: <Widget>[
          imageCarousel,
           Padding(padding:const EdgeInsets.all(10.0),
           child:Text('Departments',style:TextStyle(
             fontSize: 15.0,
             color: Colors.blue[700],
             fontFamily: 'montserrat',
             fontWeight: FontWeight.bold
             ),
             
             ),           
           ),
           HorizontalList(),
           Padding(padding: const EdgeInsets.all(10.0),
           child:Text('Recent',style:TextStyle(
             fontSize: 15.0,
             color: Colors.blue[700],
             fontFamily: 'montserrat',
             fontWeight: FontWeight.bold
             ),
             
             ),           
           ),
          Container(
             height: 320,
            child: GeneralNotice(),
           )
          

        ],

      ),
         
       
      
        
      );
  }
}