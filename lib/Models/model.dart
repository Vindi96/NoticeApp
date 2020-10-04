
class User{
  final String uid;
  final String category;
  final String name;
  final String email;
  final String url;
  final String department;
  User({this.uid,this.category,this.name,this.email,this.url,this.department});
}
class NoticeData{
  final String title;
  final String url;
  final String category;
  final String status;
  final DateTime dateTime;
  final String noticeId;
  final String department;

  NoticeData({this.title,this.url,this.category,this.status,this.dateTime,this.noticeId,this.department});

}

 
