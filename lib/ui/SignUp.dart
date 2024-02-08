import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

// bool loading = false;
class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(
                height: 20,
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
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // setState(() {
                    //   loading=true;
                    // });
                  _auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString()).then((value){
                        Navigator.pop(context);
                        Utils().toastMessage('user registered');
                    // setState(() {
                    //   loading=false;
                    // });

                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    // setState(() {
                    //   loading=false;
                    // });
                  });}
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Log in'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
