import 'package:facultynoticeboard/Services/auth.dart';
import 'package:facultynoticeboard/Shared/loading.dart';

import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
    final Function toggleview;
    SignIn({this.toggleview});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey =GlobalKey<FormState>();
  bool loading = false;
  String email='';
  String password='';
  String error='';
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
                    
                    logo('Sign In'),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration: new InputDecoration(labelText: 'Email'),
                        
                        validator: (value) {
                          return value.isEmpty ? 'Enter an Email' : null;
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
                    FlatButton(
                      child: Container(
                        alignment: Alignment(1.25, 0.0),
                        child: Text(
                          'Forgot Your Password?',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: 55.0),
                    SizedBox(
                      width: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        child: Text('Sign In'),
                        color: Colors.blue[700],
                        textColor: Colors.white,
                        onPressed: ()async {
                           if(_formKey.currentState.validate()){
                             setState(() => loading=true);
                           dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                           if(result==null){
                             setState(() {
                               error = 'could not sign in with those credential';
                               loading= false;
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
                          text: 'Don\'t have an Account?',
                          style: TextStyle(color: Colors.grey[700]),
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: ' SignUp',
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
Widget logo(String topic) {
  return Column(
    
    children: <Widget>[
      
      new Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(15,50, 0, 0),
                              child: Text(
                                'Notices',
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                                ),
                            ),
                             Container(
                              padding: EdgeInsets.fromLTRB(10,115, 0, 0),
                              child: Text(
                                '$topic',
                                style: TextStyle(
                                  fontSize: 70.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                                ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(240,115, 0, 0),
                              child: Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 90.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                                ),
                            )
                            
                          ],
                        ),
                      ),
    ],
  );
    

}
