import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/Login%20Phone%20Number/login_with_phone_number.dart';
import 'package:login_page/Login%20Phone%20Number/verify_code.dart';
import 'package:login_page/ui/auth/Sign%20up_Screen.dart';
import 'package:login_page/ui/posts/postScreen.dart';
import 'package:login_page/widgets/round_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/utils.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool valvalidator = false;
  //  bool loading =false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    // setState(() {
    //   loading=true;
    // });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      final sn = SnackBar(content: Text("Login compleated"));
      ScaffoldMessenger.of(context).showSnackBar(sn);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      // setState(() {
      //   loading=true;
      // });
    }).onError((error, stackTrace) {
      final sn = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(sn);
// setState(() {
//   loading=true;
// });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formkey,
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
                            hintText: 'Password',
                            suffixIcon: Icon(Icons.lock_open)),
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
                  title: "Login",
                  // loading:loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  }),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgrtPassowrdScreen()),
                      );
                    },
                    child: Text('Foget Password?')),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text('Sign Up'))
                ],
              ),
              SizedBox(
                height: 10,
              ),

          InkWell(
            child:  Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black,
                  )
              ),
              child: Center(
                child: Text('Login with phone'),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verificationId: '',)));
            },
          ),

            ],
          ),
        ),
      ),
    );
  }
}
