// ignore_for_file: prefer_const_constructors

import 'package:e_summit25/main.dart';
import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/gloabals.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
   final authservice = Auth();
   final _otpcontroller = TextEditingController();
   
   late String name;
  late String number;
  late String email;
  late String password;
  late String rollno;
  Map<String, dynamic>? userInfo;
  
  
   bool _isLoading = false;

   

   @override
    void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the email from the arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      name = args['name'];
      number = args['number'];
      email = args['email'];
      password = args['password'];
      rollno = args['rollno'];
    } else {
      Fluttertoast.showToast(msg: "No email provided");
      Navigator.pop(context);
    }
  }

   void verifyOTP() async {
    final otp = _otpcontroller.text;
    final email1 = email;

    if (otp.isEmpty || email.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter OTP and email");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await authservice.verifyOTP(otp, email1);
      Fluttertoast.showToast(msg: "OTP verified successfully.");
      final response = await supabase.rpc('insert_user', params: {
      'p_name': name,
      'p_phone_no': number,
      'p_email': email,
      'p_password_hash': password,
      'p_roll_no' :  rollno, // insert roll number heree
    }
    
    
    );
      // authservice.insertUser(name, number, email, password);

        authservice.fetchUserInfo();
        Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (route)=> false);
      
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }


  }


  void resendOTP() async {
    try {
      final ResendResponse res = await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      if (res.messageId != null) {
        Fluttertoast.showToast(msg: res.messageId!.hashCode.toString());
      } else {
        Fluttertoast.showToast(msg: "OTP resent successfully.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  



  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(255, 255, 255, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(255, 255, 255, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    );

    return Stack(
      children: [

        Container(
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
          child: const Column(
            children: [],
          ),
        ),
        Scaffold(
          
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
         
          body: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Enter OTP",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: const Color.fromARGB(255, 232, 232, 232)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    // defaultPinTheme: defaultPinTheme,
                    // focusedPinTheme: focusedPinTheme,
                    // submittedPinTheme: submittedPinTheme,
        
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                    controller: _otpcontroller
                    
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:  Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: verifyOTP,
                        child: Text("Verify OTP",
        
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter'
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            // Navigator.popAndPushNamed(context, 'verif');
                            resendOTP();
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            ),
            
          ),
          
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}