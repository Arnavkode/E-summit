// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Email: $_email, Password: $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Gradient
        Container(
          width: ScreenWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(39, 93, 173, 1),
                Color.fromRGBO(18, 18, 18, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment(0, -0.5),
            ),
          ),
        ),

        // Card Container with Form
        Positioned(
          bottom: 0.1 * ScreenHeight(context),
          left: 0.1 * ScreenWidth(context),
          child: Container(
            width: 0.8 * ScreenWidth(context),
            height: 0.7 * ScreenHeight(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.0,
              ),
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
                  SizedBox(height: 0.1 * ScreenHeight(context)),

                  Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: "Inter-reg",
                      fontSize: 22,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),

                  // Form Section
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Email Field
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value!.isEmpty ? "Enter your email" : null,
                            onSaved: (value) => _email = value!,
                          ),
                          SizedBox(height: 15),

                          // Password Field
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value!.length < 6 ? "Password too short" : null,
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(height: 20),

                          // Submit Button
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Welcome Text
        Padding(
          padding: EdgeInsets.only(left: 0.03 * ScreenHeight(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.16 * ScreenHeight(context)),
              Text(
                "Welcome Back!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Inter",
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),

        // Transparent AppBar
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
