import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/ui/Screen/Login_With_Phone_Number.dart';
import 'package:untitled6/ui/Screen/forgot_password.dart';
import 'package:untitled6/ui/Screen/post_screen.dart';
import 'package:untitled6/utils/utils.dart';

import 'SignUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value) {
          Utils().toastMessage(value.user!.email.toString());
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> PostScreen()));

    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Welcome',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: Colors.deepPurple,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Enter e-mail',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.deepPurple,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller: passwordController,
                              cursorColor: Colors.deepPurple,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  prefixIcon: Icon(
                                    Icons.lock_open_rounded,
                                    color: Colors.deepPurple,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(


                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ForgotPassword()));
                      },
                      child: Text('Forgot password ?')),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
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
              const SizedBox(height: 10),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> LoginWithPhone()));
                },
                child: Container(
                  height: 50,width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.deepPurple
                      )
                  ),
                  child: Center(
                    child: Text('Login with phone number'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignUp()));
                      },
                      child: Text('Sign Up'))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
