import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Upload',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/foldername/' + DateTime.now().microsecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadeTask =
                      ref.putFile(_image!.absolute);

                  Future.value(uploadeTask).then((value)async {
                    var newUrl =await ref.getDownloadURL();

                    databaseRef.child('1').set({
                      'id': '1234',
                      'title': newUrl.toString(),
                    }).then((value) {
                      // setState(() {
                      //   loading = true;
                      // });
                      final sn = SnackBar(content: Text("Uploaded"));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                    }).onError((error, stackTrace) {
                      // setState(() {
                      //   loading = true;
                      // });
                    });

                    final sn = SnackBar(content: Text("Uploaded"));
                    ScaffoldMessenger.of(context).showSnackBar(sn);
                  }).onError((error, stackTrace) {
                    final sn = SnackBar(content: Text(error.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(sn);
                  });
                })
          ],
        ),
      ),
    );
  }
}
