import 'package:flutter/material.dart';
import 'package:untitled6/ui/Screen/Splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splash splash=Splash();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.local_fire_department_rounded,color: Colors.orange,size: 100,),
      ),
    );
  }
}
