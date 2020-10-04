
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getposts()async{
    var firestore=Firestore.instance;
    QuerySnapshot qn=await firestore.collection('Notices').getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getposts(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child:Text('loading'));
        }else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(snapshot.data[index].data['title']),
              );

          });
        }

      },),
    );
  }
}
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}