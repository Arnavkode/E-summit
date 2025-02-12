import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginState();
    });
  }

  void _checkLoginState() async {
    var box = Hive.box('userBox');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
   

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/dashboard');
       Fluttertoast.showToast(msg: "Welcome back");
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}