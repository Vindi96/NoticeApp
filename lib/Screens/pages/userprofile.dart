import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:facultynoticeboard/Services/db.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  final UserService userService =UserService();
  String name;
  File _userPic;
  String picurl;
  String email;
  String uid;
  String url;
  @override
  void initState() {
    
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      picurl=user.photoUrl.toString();
      name=user.displayName.toString();
      email=user.email.toString();
      uid=user.uid.toString();
    }).catchError((e){
      print(e);
    });
  }
  
  @override
  
  Widget build(BuildContext context) {
    Future getImage() async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
     setState(() {
        _userPic=image;
        print('image path: $_userPic');
      });
  }
   Future uploadPic(BuildContext context)async{
      String fileName=basename(_userPic.path);
      final StorageReference firebaseStorageRef=FirebaseStorage()
      .ref().child('notices/$fileName');
      final StorageUploadTask uploadTask=firebaseStorageRef.putFile(_userPic);
      
     StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
    
     String downloadurl = await taskSnapshot.ref.getDownloadURL();
     url=downloadurl.toString();
     userService.updateUrl(uid,{'url':'$url'});
     Navigator.pop(context);
     }
    final user = Provider.of<User>(context);
    
    
        
return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
         style: TextStyle(
           fontFamily: 'Montserrat',
           fontWeight: FontWeight.bold,
           color: Colors.white,
         ),        
        ),
      backgroundColor: Colors.blue[800],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0,0 ,50),
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          
                          radius: 70,
                        
                          child:ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_userPic!=null)?Image.file(
                            _userPic,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "$picurl",    fit: BoxFit.fill,
                          ),
                        ),
                      ),
                        ),
                        Positioned(bottom: 1, right: 1 ,child: Container(
                          height: 40, width: 40,
                          child: IconButton(
                           icon:Icon(Icons.add_a_photo),
                             color: Colors.white,
                             onPressed: (){
                               getImage().then((context){
                                       uploadPic(context);
                                       
                                     });
 
                             },
                          ),
                          
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: Text(
                     'Name' ,
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Neucha'),
                    ),
                    subtitle:Text(
                      '$name',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Neucha'),
                    ) ,
                    trailing: IconButton(icon: Icon(Icons.mode_edit), onPressed: (){
                        dialogTrigger(context,uid);
                    }),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Neucha'),
                    ),
                    subtitle:Text(
                      '$email',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Neucha'),
                    ) ,
                    
                  ),
                ),
                SizedBox(height:50.0),
                FlatButton(
                  child: Text('Log Out',style: TextStyle(color: Colors.white70),),
                  color: Colors.red[300],
                  onPressed:()async{await _auth.signOut();} ,
                  )
              ],
            ),
          ),
      ),
      
    );
      
   } 
  
  Future<bool>dialogTrigger(BuildContext context,docId)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Do you want to update your user name'),
          content: TextField(
                            decoration: new InputDecoration(labelText: 'New Name'),
                            onChanged: (value) {
                              setState(() => name = value);
                            }),
                
             
            actions: <Widget>[
              FlatButton(
              child: Text('update'),
              textColor: Colors.blue,
              onPressed: (){
                userService.updateName(docId,{'name':'$name'});
                Navigator.pop(context);
              },
            )
            ],
            
          
        );
      }
    );
  }
}
