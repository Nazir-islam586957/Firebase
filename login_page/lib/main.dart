import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Upload_Image/upload_image.dart';
import 'firebase_options.dart';
import 'firestore/firestore_list_screen.dart';
import 'ui/auth/login screen.dart';
import 'ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
//main project
home:LoginScreen (),
//     home: UploadImageScreen(),

     //..firesotre er jonno
     // home:FireStoreScreen (),
    );
  }
}
