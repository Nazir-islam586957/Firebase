import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/round_button.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final firestore=FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              maxLines: 4,

              controller: postController,
              decoration: InputDecoration(
                helperText: 'What is your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            RoundButton(
              title: 'Add',
              onTap: () {
                String id=DateTime.now().microsecondsSinceEpoch.toString();
                firestore.doc(id).set({
                  'title':postController.text.toString(),
                  'id':id
                }).then((value){
                  final sn=SnackBar(content: Text("Add Sucess"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                }).onError((error, stackTrace) {
                  final sn=SnackBar(content: Text(error.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                });

              },
            ),
          ],
        ),
      ),
    );
  }


}










