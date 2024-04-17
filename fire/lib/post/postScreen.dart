
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



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
              maxLength: 100,
              controller: postController,
              decoration: InputDecoration(
                helperText: 'What is your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
        ElevatedButton(onPressed: (){
          databaseRef.child("1").set({
            "title":"stdrtf"
          });
        }, child: Text("gg"))
          ],
        ),
      ),
    );
  }
}
