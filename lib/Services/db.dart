import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facultynoticeboard/Models/model.dart';
import 'package:facultynoticeboard/Models/notice.dart';
import 'package:facultynoticeboard/Screens/components/unapprovednotices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService{
  
  final String uid;
  final String email;
  final String name;
  final String category;
  final String department;
  final String url;


  
  UserService({this.uid,this.email,this.name,this.category,this.department,this.url});

  final CollectionReference userCollection=Firestore.instance.collection('Users');
  
  Future updateUserData(String uid,String email,String name,String category,String department,String url)async{
    return await userCollection.document(uid).setData({
      'uid':uid,
      'name':name,
      'email':email,
      'category':category,
      'department':department,
      'url':url,
      
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
      department: snapshot.data['department'],
      url:snapshot.data['url']
      
    );
  }
   Future getuser(uid)async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Users').getDocuments();
    return qn.documents;
  }
  // get current user
  Future getcurentuser()async{
    return await FirebaseAuth.instance.currentUser();
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
    updateUrl(docId,newvalue){
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
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'cis').orderBy("dateTime",descending:true);
  final Query unapprovednr = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'nr');
  final Query unapprovedsport = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'Sport');
  final Query unapprovedpst = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'pst');
  final Query unapprovedfst = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'fst');
  final Query unapprovedgeneral = Firestore.instance.collection('Notices')
  .where("status", isEqualTo: "unapproved").where('department',isEqualTo: 'all');    


  //approved notices
  final Query cis = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').limit(10)
  .orderBy("dateTime",descending:true);
  final Query nr = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').limit(10)
  .orderBy("dateTime",descending:true);
  final Query sport = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').limit(10)
  .orderBy("dateTime",descending:true);
  final Query pst = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').limit(10)
  .orderBy("dateTime",descending:true);
  final Query fst = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').limit(10)
  .orderBy("dateTime",descending:true);
  final Query all = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'all').limit(10)
  .orderBy("dateTime",descending:true);

  //cis categories
  final Query cisexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query cisMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query cistimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query cisresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query cisother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'cis').where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);
  

  //fst categories
  final Query fstexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query fstMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query fsttimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query fstresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query fstother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'fst').where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);
  //nr categories
  final Query nrexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query nrMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query nrtimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query nrresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query nrother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'nr').where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);
  //sport categories
  final Query sportexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query sportMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query sporttimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query sportresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query sportother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'sport').where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);
  //pst categories
  final Query pstexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query pstMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query psttimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query pstresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query pstother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('department',isEqualTo:'pst').where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);

  //all categories
  final Query allexams = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory', isEqualTo: 'Exams')
  .orderBy("dateTime",descending:true);
  final Query allMB = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory', isEqualTo: 'Mahapola/Bursary')
  .orderBy("dateTime",descending:true);
  final Query alltimetables = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory', isEqualTo: 'TimeTables')
  .orderBy("dateTime",descending:true);
  final Query allresults = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory', isEqualTo: 'Results')
  .orderBy("dateTime",descending:true);
  final Query allother = Firestore.instance.collection('Notices')
  .where("status",isEqualTo:"approved").where('noticecategory', isEqualTo: 'Other')
  .orderBy("dateTime",descending:true);  

   Future updteNoticeData(
     String title,
     String url,
     String noticecategory,
     String status,
     DateTime dateTime,
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
        dateTime: doc.data['dateTime'].toDate(),
        noticeId: doc.data['noticeId'] ?? '',
        department: doc.data['department']?? ''

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
      department: snapshot.data['department']

    );
  }
  Future getNotices()async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Notices').getDocuments();
    return qn.documents;
  }
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
  Stream<List<Notice>>get unapprovedfacultynotices{
    return unapprovedgeneral.snapshots().map(_noticeListFromSnapshot);
  }  
  //approved notice streams
  Stream<List<Notice>>get cisnotices{
    return cis.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get allnotices{
    return all.snapshots().map(_noticeListFromSnapshot);
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
    return all.snapshots().map(_noticeListFromSnapshot);
  } 

  //exams streams
  Stream<List<Notice>>get cisexam{
    return cisexams.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get pstexam{
    return pstexams.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrexam{
    return nrexams.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fstexam{
    return fstexams.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sportexam{
    return sportexams.snapshots().map(_noticeListFromSnapshot);
  }
  //mahapola/bursary streams
  Stream<List<Notice>>get cismb{
    return cisMB.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrmb{
    return nrMB.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fstmb{
    return fstMB.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get pstmb{
    return pstMB.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sportmb{
    return sportMB.snapshots().map(_noticeListFromSnapshot);
  } 
   
  //nr streams
Stream<List<Notice>>get cistt{
    return cistimetables.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrtt{
    return nrtimetables.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fsttt{
    return fsttimetables.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get psttt{
    return psttimetables.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sporttt{
    return sporttimetables.snapshots().map(_noticeListFromSnapshot);
  } 

  //pst streams
Stream<List<Notice>>get cisres{
    return cisresults.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrres{
    return nrresults.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fstres{
    return fstresults.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get pstres{
    return pstresults.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sportres{
    return sportresults.snapshots().map(_noticeListFromSnapshot);
  } 
 
  //sport streams
Stream<List<Notice>>get cisothers{
    return cisother.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get nrothers{
    return nrother.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get fstothers{
    return fstother.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get pstothers{
    return pstother.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get sportothers{
    return sportother.snapshots().map(_noticeListFromSnapshot);
  } 
  //all streams
  Stream<List<Notice>>get allexam{
    return allexams.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get allothers{
    return allother.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get allmb{
    return allMB.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get allresult{
    return allresults.snapshots().map(_noticeListFromSnapshot);
  } 
  Stream<List<Notice>>get alltimetable{
    return alltimetables.snapshots().map(_noticeListFromSnapshot);
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