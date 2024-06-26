import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
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

                 String id = DateTime.now().microsecondsSinceEpoch.toString();


                databaseRef.child(id).set({
                  "title": postController.text.toString(),
                  "id":id,
                }).then((value){

                  final sn = SnackBar(content: Text("Add compleated"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                }).onError((error, stackTrace){
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










