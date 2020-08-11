import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Models/notice.dart';

class UserService{
  
  final String uid;
  final String email;
  final String name;
  final String category;
  final String department;


  
  UserService({this.uid,this.email,this.name,this.category,this.department});

  final CollectionReference userCollection=Firestore.instance.collection('Users');
  
  Future updateUserData(String uid,String email,String name,String category,String department)async{
    return await userCollection.document(uid).setData({
      'uid':uid,
      'name':name,
      'email':email,
      'category':category,
      'department':department
      
    });
 
 }
 //user list from snapshot
 List<User>_userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
        category:doc.data['category'] ?? '',
        


      );
    }).toList();
  }
  //userData from snapshot
  User _userDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
      uid:uid,
      category: snapshot.data['category'],
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      department: snapshot.data['department']
      
    );
  }
   Future getuser(uid)async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Users').getDocuments();
    return qn.documents;
  }
 
 //get user stream
  Stream<List<User>>get users{
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
  Stream<QuerySnapshot> get user{
    return userCollection.snapshots();
  }
  //get user doc Stream
  Stream<User>get userData{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
  updateName(docId,newvalue){
    Firestore.instance.collection('Users').document(docId).updateData(newvalue);
  }

 
}
class NoticeService{
  final String title;
  final String url;
  final String noticecategory;
  final String status;
  final String dateTime;
  final String noticeId;
  final String department;
  NoticeService({this.title,this.url,this.noticecategory,this.status,this.dateTime,this.noticeId,this.department});
  String curentdept(deptname){
    return deptname;
  }

  final CollectionReference noticeCollection=Firestore.instance.collection('Notices');

  //unapproved notices
  final Query unapprovedcis = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'CIS');
  final Query unapprovednr = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'NR');
  final Query unapprovedsport = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'Sport');
  final Query unapprovedpst = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'PST');
  final Query unapprovedfst = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'FST');
  final Query unapprovedgeneral = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('noticecategory',isEqualTo: 'General');    

  //approved notices
  final Query cis = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'CIS')
  .orderBy('dateTime',descending:true);
  final Query nr = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'NR');
  final Query sport = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'Sport');
  final Query pst = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'PST');
  final Query fst = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'FST');
  final Query general = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory',isEqualTo:'General')
  .orderBy('dateTime',descending:false);
  final Query recent=Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where("date",isEqualTo:DateTime.now().toString());

   Future updteNoticeData(
     String title,
     String url,
     String noticecategory,
     String status,
     String dateTime,
     String department,
     String noticeId,
     )async{
    return await noticeCollection.document(noticeId).setData({     
      'title':title,
      'url':url,
      'noticecategory':noticecategory,
      'status':status,
      'dateTime':dateTime,
      'department':department,
      'noticeId':noticeId,
      

    });
  }
  //notice list from snapshot
  List<Notice>_noticeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Notice(
        title:doc.data['title'] ?? '',
        url: doc.data['url'] ?? '',
        category: doc.data['noticecategory'] ?? 'General',
        status: doc.data['status'] ?? 'unapproved',
        dateTime: doc.data['dateTime'] ?? '',
        noticeId: doc.data['noticeId'] ?? ''

      );
    }).toList();
  }
  //notice data from snapshot
  NoticeData _noticeDataFromSnapshot(DocumentSnapshot snapshot){
    return NoticeData(
      noticeId: snapshot.data['noticeId'],
      title: snapshot.data['title'],
      category: snapshot.data['category'],
      url: snapshot.data['url'],
      dateTime: snapshot.data['dateTime'],
      status: snapshot.data['status'],

    );
  }
  /*Future getNotices()async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Notices').getDocuments();
    return qn.documents;
  }*/
  //get notice stream
  Stream<List<Notice>>get notices{
    return noticeCollection.snapshots().map(_noticeListFromSnapshot);
  }
  //unapproved notce streams
  Stream<List<Notice>>get unapprovedcisnotices{
    return unapprovedcis.snapshots().map(_noticeListFromSnapshot);
  }  
  Stream<List<Notice>>get unapprovednrnotices{
    return unapprovednr.snapshots().map(_noticeListFromSnapshot);
  }  
  Stream<List<Notice>>get unapprovedpstnotices{
    return unapprovedpst.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get unapprovedfstnotices{
    return unapprovedfst.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get unapprovedsportnotices{
    return unapprovedsport.snapshots().map(_noticeListFromSnapshot);
  }  
  Stream<List<Notice>>get unapprovedgeneralnotices{
    return unapprovedgeneral.snapshots().map(_noticeListFromSnapshot);
  }  
  //approved notice streams
  Stream<List<Notice>>get cisnotices{
    return cis.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrnotices{
    return nr.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get pstnotices{
    return pst.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fstnotices{
    return fst.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sportnotices{
    return sport.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get generalnotices{
    return general.snapshots().map(_noticeListFromSnapshot);
  } 
  // recent notices
  Stream<List<Notice>>get recentnotices{
    return recent.snapshots().map(_noticeListFromSnapshot);
  }
  //get notice doc stream
  Stream<NoticeData>get noticeData{
    return noticeCollection.document().snapshots()
    .map(_noticeDataFromSnapshot);
  }
  //update data of firebase
  updateData(selectedDoc,newValue){
    Firestore.instance.collection('Notices').document(selectedDoc).updateData(newValue)
    .catchError((e){
      print(e);
    });
  }
  deleteData(docId){
    Firestore.instance.collection('Notices').document(docId).delete()
    .catchError((e){
      print(e);
    });
  }
 

}