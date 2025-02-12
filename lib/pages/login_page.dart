import 'dart:async';

import 'package:e_summit25/main.dart';
import 'package:e_summit25/pages/account_page.dart';
import 'package:e_summit25/pages/dashboard.dart';
import 'package:e_summit25/pages/welcome_page.dart';
import 'package:e_summit25/services/Auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:e_summit25/utils/Bigbutton.dart';
import 'package:e_summit25/utils/Entryfield.dart';
import 'package:e_summit25/utils/Passwordfield.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final authservice = Auth();
 
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
  bool _isLoading = false;

 void login() async{

  final email = _emailController.text;
  final password = _passwordController.text;

  // attempt login
  setState(() {
    _isLoading = true;
  });
  try{
    await authservice.signinwithEmailPassword(email, password);
    Fluttertoast.showToast(msg: "Login successful");
    authservice.fetchUserInfo();
    Navigator.pushReplacementNamed(context, '/dashboard');
  }
  catch(e){
    if(mounted){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  setState(() {
    _isLoading = false;
  });

 }

 



  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            width: ScreenWidth(context),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(39, 93, 173, 1),
                  Color.fromRGBO(18, 18, 18, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment(0, -0.5),
              ),
            ),
          ),
          Positioned(
            bottom: 0.1 * ScreenHeight(context),
            left: 0.1 * ScreenWidth(context),
            child: Container(
              width: 0.8 * ScreenWidth(context),
              height: 0.7 * ScreenHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xffd3c0c0).withOpacity(0.15),
                    Color(0xff222823).withOpacity(0.15)
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(0.05 * ScreenWidth(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 0.07 * ScreenHeight(context),
                        ),
                        children: [
                          TextSpan(
                            text: "Wel",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: "come",
                            style: TextStyle(color: Color(0xFF275DAD)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.08 * ScreenHeight(context)),
                    const Text("Email",
                        style: TextStyle(
                            fontFamily: "Inter-reg",
                            fontSize: 22,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                    const SizedBox(height: 8),
                    EntryField(
                        hintText: "Enter your email",
                        controller: _emailController),
                    SizedBox(height: 0.02 * ScreenHeight(context)),
                    const Text("Password",
                        style: TextStyle(
                            fontFamily: "Inter-reg",
                            fontSize: 22,
                            color: Colors.white,
                            decoration: TextDecoration.none
                            )),
                    const SizedBox(height: 8),
                    PasswordField(
                        hintText: "Enter password",
                        controller: _passwordController),

                      // TextButton(onPressed: (){
                      //   Navigator.pushNamed(context, '/reset');
                      // }, child: const Text("Forgot password?", style: TextStyle(color: Colors.blue, fontSize: 16),)),
                      



                    const Spacer(),
                    Align(alignment:Alignment.center , child: Bigbutton(label: "Sign in", onTap: login))
                    
              ],
            ),
          ),
          // Positioned(
          //     top: 0,
          //     right: 0,
          //     left: 0,
          //     child: AppBar(backgroundColor: Colors.transparent)
          //     ),
            )
          ),
          if(_isLoading)
            const Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF275DAD)),
            ))
        ],
      ),
    );
  }
}
