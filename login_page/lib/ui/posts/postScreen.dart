import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_page/ui/auth/login%20screen.dart';

import '../utils/utils.dart';
import 'add_posts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editContoller = TextEditingController();
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
        title: Text("Post"),
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Serach',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: Text('Loading'),
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title,snapshot.child('id').value.toString());
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            )),
                        PopupMenuItem(
                          value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                        ))
                      ],
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
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
                    ref.child(id).update({
                      'title': editContoller.text.toLowerCase()
                    }).then((value) {
                      final sn = SnackBar(content: Text("Post Updated.."));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                    }).onError((error, stackTrace) {
                      final sn = SnackBar(content: Text(error.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sn);
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}

// Expanded(
//     child: StreamBuilder(
//   stream: ref.onValue,
//   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//
//
//     if(!snapshot.hasData) {
//       return CircularProgressIndicator();
//     }else{
//       Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
//       List<dynamic>list=[];
//       list.clear();
//       list= map.values.toList();
//       return ListView.builder(
//           itemCount: snapshot.data!.snapshot.children.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(list[index]['title']),
//               subtitle: Text(list[index]['id']),
//             );
//           });
//     }
//
//   },
// )),
