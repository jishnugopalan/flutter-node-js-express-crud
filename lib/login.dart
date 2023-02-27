import 'package:authdemo/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name="",email="",phone="",password="";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool issigned=false;
  logIn() async {
    if(_formKey.currentState!.validate()){
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            DashBoard()), (Route<dynamic> route) => false);


      }on FirebaseAuthException catch (e) {
        showError(e.message.toString());
        print(e.code);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }

  }
  showError(String errorMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMsg),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  getUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    await firebaseUser?.reload();

    if (firebaseUser != null) {
      setState(() {
        issigned = true;
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            DashBoard()), (Route<dynamic> route) => false);

      });
    }

  }
  // signInWithGoogle() async {
  //   await GoogleSignIn().signOut();
  //   User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   await GoogleSignIn().signIn().then((value) async {
  //     final GoogleSignInAuthentication? googleAuth = await value?.authentication;
  //
  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     print(FirebaseAuth.instance.currentUser);
  //     this.getUser();
  //
  //   });
  //
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Email"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        setState(() {
                          email=value!;
                        });

                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Password"
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        setState(() {
                          password=value!;
                        });

                      },
                    ),
                  ),
                  ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: logIn
                  ),
                  TextButton(onPressed: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        HomePage()));

                  }, child: Text("Register")),
                  // TextButton(onPressed: signInWithGoogle, child: Text("Sign in with Google"))

                ],

              ))
        ],
      ),
    );
  }
}

