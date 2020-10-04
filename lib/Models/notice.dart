import 'package:cloud_firestore/cloud_firestore.dart';

class Notice{
  final String title;
  final String url;
  final String category;
  final String status;
  final  dateTime;
  final String noticeId;
  final String department;

  Notice({this.title,this.url,this.category,this.status,this.dateTime,this.noticeId,this.department});
}