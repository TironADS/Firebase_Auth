import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/ui/Screen/Verification_Code.dart';
import 'package:untitled6/utils/utils.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {


  final auth = FirebaseAuth.instance;
  final PhoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('Login with Phone number',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
            SizedBox(height: 50,),
            SizedBox(
              height: 50, width: 300,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: PhoneNumberController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone,color: Colors.deepPurple,),
                    hintText: '+91 9876543210'
                ),
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {


                auth.verifyPhoneNumber(
                  phoneNumber: PhoneNumberController.text,
                    verificationCompleted: (_){

                    },
                    verificationFailed: (e){
                    Utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Verification(verificationId: verificationId,)));
                    },
                    codeAutoRetrievalTimeout: (e){
                      Utils().toastMessage(e.toString());
                    });
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
