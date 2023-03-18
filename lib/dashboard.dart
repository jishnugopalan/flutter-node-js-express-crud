import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:authdemo/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'firebase_options.dart';
import 'package:image_picker/image_picker.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final storage = new FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();
  String? jwt;
  String userId="";
  bool isLoggedin=true;
  XFile? _image;


  Future cameraImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,

    );

    List<String>? s=pickedFile?.path.toString().split("/");
    // print(s?.length.toString());
    // print(s![s.length-1].split(".")[1]);

    final bytes=await File(pickedFile!.path).readAsBytes();
    final base64=base64Encode(bytes);
    // print(base64);

    var pic="data:image/"+s![s.length-1].split(".")[1]+";base64,"+base64;
    print(pic);



    setState(() {
      _image = pickedFile;
    });
  }
  encodeToBase64(String path)async{
    final bytes=await File(path).readAsBytes();
    final base64=base64Encode(bytes);
    print(base64);
    return base64;
  }

    Future<void> checkAuthentication() async {
    try{
      Map<String, String> allValues = await storage.readAll();
      if(allValues.isEmpty){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
      else{
       this.getToken();

      }
    }catch(e){

    }
  }

  Future<void>getToken() async {
    String normalizedSource;
    String userid;
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      jwt=allValues["token"];
    });
    normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
    userid= json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
    print(userid);
    setState(() {
      userId=userid;
    });
    // this.getUser();
    // this.getWalletAmount();
    // this.getJoinedMembers();



  }

  logout() async {
    await storage.delete(key: "token");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

  }
  void initState(){
    super.initState();
    this.checkAuthentication();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),

      ),
      body: Container(
        child: ListView(
          children: [
            ElevatedButton(onPressed: cameraImage, child: Text("Get Pick")),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: logout,
            )
          ],
        ),
      ),
    );
  }
}