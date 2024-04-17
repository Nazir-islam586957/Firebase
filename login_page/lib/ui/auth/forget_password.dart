import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/widgets/round_button.dart';

class ForgrtPassowrdScreen extends StatefulWidget {
  const ForgrtPassowrdScreen({super.key});

  @override
  State<ForgrtPassowrdScreen> createState() => _ForgrtPassowrdScreenState();
}

class _ForgrtPassowrdScreenState extends State<ForgrtPassowrdScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
              title: 'Forget',
              onTap: () {
                auth
                    .sendPasswordResetEmail(
                        email: emailController.text.toString())
                    .then((value) {
                  final sn = SnackBar(content: Text("We sent your email to recover password, please check email"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                }).onError((error, stackTrace) {
                  final sn = SnackBar(content: Text(error.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
