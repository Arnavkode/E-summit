import 'package:e_summit25/main.dart';
import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/Bigbutton.dart';
import 'package:e_summit25/utils/Entryfield.dart';
import 'package:e_summit25/utils/Numberfield.dart';
import 'package:e_summit25/utils/Passwordfield.dart';
import 'package:e_summit25/utils/gloabals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/Datas.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final authservice = Auth();
  bool _isLoading = false;

  final _namecontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _rollnocontroller = TextEditingController();
  String? _validatePassword(String value) {
    if (value.length < 6 || value.length > 12) {
      return "Password must be 6-12 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "At least one uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "At least one number";
    }

    return null; // No errors
  }

  String? _validateRollNumber(String value) {
    if (value.length != 9) {
      return "Invalid Roll Number";
    }
    return null; // No errors
  }

  Future<bool> checkUserExists(String email) {
    return authservice.checkUserExists(email);
  }

  void signup() async {
    final name = _namecontroller.text.trim();
    final number = _numbercontroller.text.trim();
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    final confirmpassword = _confirmpasswordcontroller.text.trim();
    final rollno = _rollnocontroller.text.trim();

    if (name.isEmpty ||
        number.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty ||
        rollno.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
      return;
    }

    if (password != confirmpassword) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return;
    }

    if (_validatePassword(password) != null) {
      Fluttertoast.showToast(msg: "Password requirements do not match");
      return;
    }

    if (_validateRollNumber(rollno) != null) {
      Fluttertoast.showToast(msg: "Invalid Roll number");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool userExists = false;
      userExists = await checkUserExists(email);
      if (userExists == true) {
        Fluttertoast.showToast(
            msg: "An account with this email already exists");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await authservice.signupwithEmailPassword(email, password);
      Fluttertoast.showToast(msg: "OTP sent successfully");
      userEmail = email;
      userName = name;
      userPhone = number;
      userRoll = rollno;
      Navigator.pushNamed(context, "/otppage", arguments: {
        'name': name,
        'number': number,
        'email': email,
        'password': password,
        'rollno': rollno,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Hide keyboard when tapping outside
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            width: ScreenWidth(context),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(39, 93, 173, 1),
                  Color.fromRGBO(18, 18, 18, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment(0, -0.5),
              ),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: 0.1 * ScreenWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.13 * ScreenHeight(context)),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Inter",
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 0.1 * ScreenHeight(context)),
                BasicText("Name"),
                const SizedBox(height: 8),
                EntryField(
                  hintText: "Enter name",
                  controller: _namecontroller,
                ),
                SizedBox(height: 0.02 * ScreenHeight(context)),
                BasicText("Roll No."),
                const SizedBox(height: 8),
                EntryField(
                  hintText: "Enter Roll number",
                  controller: _rollnocontroller,
                ),
                SizedBox(height: 0.02 * ScreenHeight(context)),
                BasicText("Phone No."),
                const SizedBox(height: 8),
                NumberField(
                  hintText: "Enter number",
                  controller: _numbercontroller,
                ),
                SizedBox(height: 0.02 * ScreenHeight(context)),
                BasicText("Email"),
                const SizedBox(height: 8),
                EntryField(
                  hintText: "Enter Email",
                  controller: _emailcontroller,
                ),
                SizedBox(height: 0.02 * ScreenHeight(context)),
                BasicText("Password"),
                const SizedBox(height: 8),
                PasswordField(
                  hintText: "Enter Password",
                  controller: _passwordcontroller,
                ),
                SizedBox(height: 0.02 * ScreenHeight(context)),
                BasicText("Re-enter Password"),
                EntryField(
                  hintText: "Re-enter here",
                  controller: _confirmpasswordcontroller,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Bigbutton(label: "Get OTP", onTap: signup),
                ),
                if (_isLoading == true)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF275DAD),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
