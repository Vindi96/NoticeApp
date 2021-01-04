import 'package:facultynoticeboard/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AdminDrawerpart extends StatefulWidget {
  @override
  _AdminDrawerpartState createState() => _AdminDrawerpartState();
}

class _AdminDrawerpartState extends State<AdminDrawerpart> {
  Widget useremail(){
     return FutureBuilder(
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                      '$email',
                        style: TextStyle(
                        fontWeight:FontWeight.bold,
                      ),
                );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
          future: FirebaseAuth.instance.currentUser(),
        );
   }
   Widget username(){
     return FutureBuilder(
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                      '$name',
                        style: TextStyle( 
                        fontWeight:FontWeight.bold,                                               
                        ),
                );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
          future: FirebaseAuth.instance.currentUser(),
        );
                      
              
                
   }


  String profilePicUrl;
  String name;
  String email;
   @override
  void initState() {
    
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      profilePicUrl=user.photoUrl;
      name=user.displayName;
      email=user.email;
    }).catchError((e){
      print(e);
    });
  }  


   final AuthService _auth = AuthService();
   void navigateTo(String name){
     Navigator.of(context).pushNamed('/$name');
   }
   Widget tabs({Icon icon, String name, }){
     return InkWell(
                onTap:(){
                  navigateTo(name);
                },
                child: ListTile(
                  title:Text(name),
                  leading: icon,
                ),
                );
   }
  @override
  Widget build(BuildContext context) {
    return Drawer(
         child: ListView(
            children:<Widget>[
              UserAccountsDrawerHeader(
                accountName: username(),
                accountEmail: useremail(),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(backgroundColor: Colors.grey,),
                  ),
                  decoration: BoxDecoration(
                    color:Colors.blue[800]
                  ),
              ),
              tabs(icon:Icon(Icons.home),name:'DeanHome'),
              tabs(icon:Icon(Icons.account_circle),name:'My Account'),
              tabs(icon:Icon(Icons.developer_board),name:'View Notices'),
              tabs(icon:Icon(Icons.file_upload),name:'Upload Notices'),
              tabs(icon:Icon(Icons.check),name:'Approve Notice'),
              tabs(icon:Icon(Icons.settings),name:'Settings'),
             // tabs(icon:Icon(Icons.help),name:'About'),
             
              InkWell(
               onTap: ()async{
                 await _auth.signOut();
               }, 
               child: ListTile(
                 title: Text('LogOut'),
                 leading: Icon(Icons.person,color: Colors.red[500],),
               ),
               
               ),
            ]
         ),
       );
  }
}