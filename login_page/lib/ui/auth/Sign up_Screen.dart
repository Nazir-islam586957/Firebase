import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/ui/auth/login%20screen.dart';
import 'package:login_page/ui/utils/utils.dart';
import 'package:login_page/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
// final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                // key: _formkey,
                child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password', suffixIcon: Icon(Icons.lock_open)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Password';
                    }
                    return null;
                  },
                ),
              ],
            )),
            SizedBox(
              height: 30,
            ),



            RoundButton(
                title: "Sign Up",
                onTap: () {
                  _auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString())
                      .then((value) {
                    final sn = SnackBar(content: Text("SignUp compleated"));
                    ScaffoldMessenger.of(context).showSnackBar(sn);
                  }).onError((error, stackTrace) {
                    final sn = SnackBar(content: Text(error.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(sn);
                  });

                  // if(_formkey.currentState!.validate()){}
                }),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
