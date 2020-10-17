
import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facultynoticeboard/Services/db.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadNotice extends StatefulWidget {
  @override
  _UploadNoticeState createState() => _UploadNoticeState();
}

class _UploadNoticeState extends State<UploadNotice> {
  final _formKey=GlobalKey<FormState>();
  final List<String> noticrcategory=['Exams','Mahapola/Bursary','TimeTables','Results','Other'];
  File _noticepic;
  String title; 
  String url;
  String category;
  String department;
  var uuid=Uuid();
  bool loading = false;
  DateTime now=new DateTime.now();
  
  
  

  
  @override
  Widget build(BuildContext context) {
  Future getImage() async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
     setState(() {
        _noticepic=image;
        print('image path: $_noticepic');
      });
  }
   Future uploadPic(BuildContext context)async{
      String fileName=basename(_noticepic.path);
      final StorageReference firebaseStorageRef=FirebaseStorage()
      .ref().child('notices/$fileName');
      final StorageUploadTask uploadTask=firebaseStorageRef.putFile(_noticepic);
      
     StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
    
     String downloadurl = await taskSnapshot.ref.getDownloadURL();
     url=downloadurl.toString();
    }
    final user = Provider.of<User>(context);
    
  return StreamBuilder(
      stream:UserService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          User userData=snapshot.data;
          userData.department.toString();
          print(userData.department.toString());
          String getDepartmentName(){
        return userData.department.toString();  
        }
        department=getDepartmentName();
        
        
       
        
        
    return loading ? Loading(): Scaffold(
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
         

       ),
  
       body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  
                  key: _formKey,
                      child: Column(
            
          children: <Widget>[
                    
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(child: Text('Add your notice here')
                          ),
                        ),
                        Container(
                        child:(_noticepic!=null)?Image.file(_noticepic,fit: BoxFit.fill):
                        IconButton(icon:Icon(Icons.add_photo_alternate,size: 50.0,),
                        onPressed:(){
                                     getImage().then((context){
                                       uploadPic(context);
                                     });

                                   },
                        
                        ),
                        height: 450.0,
                        width:300.0,
                        color: Colors.grey[400],
                        
                        ),
                  TextFormField(
                            decoration: new InputDecoration(labelText: 'Title'),
                            
                            validator: (value) {
                              return value.isEmpty ? 'Title is Required' : null;
                            },
                            onChanged: (value) {
                             setState(() => title = value);
                            }),
                            
                     
                  DropdownButtonFormField(
                        value: category ?? 'Other',
                        items: noticrcategory.map((noticrcategory){
                          return DropdownMenuItem(
                            value: noticrcategory,
                            child: Text('$noticrcategory Category'),
                          );
                        }).toList(),
                        onChanged: (value)=>setState(()=>category=value),

                      ),
                      SizedBox(height: 20,),
                      Text('${now.day}/${now.month}/${now.year}  (${now.hour}:${now.minute}:${now.second})'),
                      SizedBox(height: 30.0,),
                    
                    Container(
                      height: 30.0,
                      width: 100.0,
                      child: RaisedButton(
                        
                        onPressed: () async {
                        setState(() => loading=true);
                        await NoticeService().updteNoticeData(
                          title,
                          url, 
                          category,
                          'unapproved',     
                           now,
                         '$department',
                          uuid.v4());
                        Navigator.of(context).pushReplacementNamed('/Upload Notices');
                        },
                        
                        child: Text('Upload',style: TextStyle(color: Colors.white),),
                        color: Colors.blue[700],
                      ),
                    )
             

          ],
          ),
                ),
              ),
      ),
      

      
      
    );
    }else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();

      }
    );


  }
}