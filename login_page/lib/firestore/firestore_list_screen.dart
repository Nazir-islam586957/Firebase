import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login screen.dart';
import '../ui/posts/add_posts.dart';
import 'add_firestore_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editContoller = TextEditingController();
  final firestore=FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("FireStore"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  final sn = SnackBar(content: Text("LogOut compleated"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                });
              },
              icon: Icon(Icons.login)),
        ],
      ),
      body: Column(
        children: [
          SizedBox( height: 10,),
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext_contex,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                  return CircularProgressIndicator();
                if(snapshot.hasError)
                  return Text('Same Error');
                return  Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context, index){
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]['title'].toString()),
                    );
                  },
                  ),);
              }),



        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  AddFirestoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title , String id)async {
    editContoller.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editContoller,
                decoration: InputDecoration(hintText: 'Edit'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}