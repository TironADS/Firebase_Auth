import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/ui/FireStore/Fire_Store_List.dart';
import 'package:untitled6/ui/Image/Upload_Image.dart';
import 'package:untitled6/ui/Screen/post_screen.dart';
import 'package:untitled6/ui/logIn.dart';

class Splash{
  void islogin(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user !=null){
      Timer(const Duration(seconds: 2),()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> UploadImageScreen())));
    }else{
      Timer(const Duration(seconds: 2),()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> LogIn())));
    }

  }
}