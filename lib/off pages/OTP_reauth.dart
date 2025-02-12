import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class OTPreauth extends StatefulWidget {
  const OTPreauth({super.key});

  @override
  State<OTPreauth> createState() => _OTPreauthState();
}

class _OTPreauthState extends State<OTPreauth> {

  final _otpcontroller = TextEditingController();
  bool _isLoading = false;
  final authservice = Auth();


  void _verifyOTP() async {
    final otp = _otpcontroller.text.trim();
    final email = ModalRoute.of(context)!.settings.arguments as String;

    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter the OTP");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await authservice.verifyOTP(otp, email);
      Fluttertoast.showToast(msg: "OTP verified successfully");
      Navigator.pushReplacementNamed(context, '/new_password');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _isLoading = false;
        
      });
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
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: const Color.fromARGB(255, 232, 232, 232),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    controller: _otpcontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
