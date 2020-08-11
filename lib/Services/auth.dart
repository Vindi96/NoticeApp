import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid) :null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
   .map(_userFromFirebaseUser);
  }

  //signin anon
  Future signInAnon()async{
    try{
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user =result.user;
     return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signin email password
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmailAndPassword(String email, String password,String name)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document for the user with the uid
      await UserService(uid: user.uid).updateUserData(user.uid, email, name,'normal user','cis');
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}