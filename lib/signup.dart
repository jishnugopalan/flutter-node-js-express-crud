import 'dart:convert';

import 'package:authdemo/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
const HomePage({Key? key}) : super(key: key);

@override
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name="",email="",phone="",password="";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool issigned = false;

  Future<void> signUp() async {
    if(_formKey.currentState!.validate()){
      Users user=new Users(name,email,phone,password);
      String userdata=jsonEncode(user);
      print(userdata);
      var client = http.Client();
      try {
        var response = await client.post(
            Uri.parse("http://10.0.2.2:3000/api/register"),
            headers: {"Content-Type": "application/json"},
            body:userdata);
        print(response.body);
        print(response.statusCode);
        // String res=jsonDecode(response.body);
        // print(res);

        if(response.statusCode!=201){
          showDialog(context: context, builder: (BuildContext context){

            return AlertDialog(
              title: Text('Error'),
              content: Text("error"),
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
        else{
          print("registration successful");

        }
        //Navigator.pushNamed(context, '/verify');
      }
      catch(e){
        print(e);
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Error'),
            content: Text("Error in signup"),
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


    }

  }
  logout(){

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
    else{
      print("Nouser");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();

  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),

      ),
      body:  Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListView(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Name"
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Name is required";

                            }
                            setState(() {
                              name=value;
                            });
                            return null;

                          },
                        ),
                      ),
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
                              labelText: "Phone"
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            setState(() {
                              phone=value!;
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
                          onPressed: signUp
                      )


                    ],
                  ))
            ],
          )
      ),
    );
  }
}