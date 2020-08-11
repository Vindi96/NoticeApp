import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:facultynoticeboard/Screens/authenticate/sign_in.dart';
import 'package:facultynoticeboard/Services/auth.dart';
import 'package:facultynoticeboard/Shared/loading.dart';

class Regester extends StatefulWidget {
  final Function toggleview;
  Regester({this.toggleview});
  @override
  _RegesterState createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final AuthService _auth = AuthService();  
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final _formKey =GlobalKey<FormState>();
   String email='';
   String password='';
   String conformpass='';
   String error='';
   bool loading = false;
   String name='';
   

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.white,
      
        body: Container(
          padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    logo('Sign Up'),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration: new InputDecoration(labelText: 'Name'),
                        
                        validator: (value) {
                          return value.isEmpty ? 'Enter your name' : null;
                        },
                        onChanged: (value) {
                          setState(() => name = value);
                        }),
                    SizedBox(height: 15.0),                    
                    TextFormField(
                        decoration: new InputDecoration(labelText: 'Email'),
                        
                        validator: (value) {
                          return value.isEmpty ? 'Enter an email' : null;
                        },
                        onChanged: (value) {
                          setState(() => email = value);
                        }),
                    SizedBox(height: 15.0),
                    TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          return value.length<6 ? 'Enter a password 6+ chars long' : null;
                        },
                        onChanged: (value) {
                          setState(() => password = value);
                        }),
                         SizedBox(height: 15.0),
                    TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(labelText: 'Conform Password'),
                        validator: (value) {
                          return value!='$password' ? 'Passwords do not match' : null;
                         
                        },                        
                        onChanged: (value) {
                          setState(() => conformpass = value);
                        }),
                    
                    SizedBox(height: 50.0),
                    SizedBox(
                      width: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        child: Text('Sign Up'),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: ()async {
                          
                         if(_formKey.currentState.validate()){
                           
                           setState(() => loading=true);
                           dynamic result = await _auth.registerWithEmailAndPassword(email, password,name);
                           if(result==null){
                             setState((){
                               error = 'please supply valid email';
                               loading=false;
                             });
                           }
                         }
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      error,
                      style:TextStyle(fontSize: 14,color: Colors.red),
                    ),
                    SizedBox(height: 15.0),
                    FlatButton(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account',
                          style: TextStyle(color: Colors.grey[700]),
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                )),
                          ],
                        ),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                       widget.toggleview();
                      },
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            )),
        
      
    );
    
  }
 
    
  }
  

