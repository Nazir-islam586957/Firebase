import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Login%20Phone%20Number/verify_code.dart';
import 'package:login_page/widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading =false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '+088 0134 567 89'),
            ),
            SizedBox(height: 50,),
            RoundButton(title: 'Login',onTap: (){


            auth.verifyPhoneNumber(
              phoneNumber: phoneNumberController.text,
                verificationCompleted: (_){

                },
                verificationFailed: (e){
                  final sn = SnackBar(content: Text("Login compleated"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                },
                codeSent: (String verificationId, int? token){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>VerifyCodeScreen(verificationId: verificationId,)));
                },
                codeAutoRetrievalTimeout: (e){
                  final sn = SnackBar(content: Text("Login compleated"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                });
            },)
          ],
        ),
      ),
    );
  }
}
