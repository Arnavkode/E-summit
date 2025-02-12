import 'package:e_summit25/off%20pages/OTP_reauth.dart';
import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/Bigbutton.dart';
import 'package:e_summit25/utils/Entryfield.dart';
import 'package:e_summit25/utils/Passwordfield.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {

  final authservice = Auth();
  bool _isLoading = false;

  void _sendReauthOTP() async {
    final email = _resetemailcontroller.text.trim();
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
       //change this
      Fluttertoast.showToast(msg: "OTP sent for reauthentication");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OTPreauth()),
      );
    }
  }


  final _resetemailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    return Stack(
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
                    Text("Reset",
                      style: TextStyle(fontFamily: "Inter",
                          fontSize: 0.06 * ScreenHeight(context),
                          color: Colors.white
                          ,decoration: TextDecoration.none
                          ),),

                    Text("password",
                      style: TextStyle(fontFamily: "Inter",
                          fontSize: 0.06 * ScreenHeight(context),
                           color: const Color(0xFF275DAD)
                          ,decoration: TextDecoration.none
                          ),),
                    SizedBox(height: 0.1 * ScreenHeight(context)),

                    Text("Email",
                        style: TextStyle(
                            fontFamily: "Inter-reg",
                            fontSize: 22,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                    const SizedBox(height: 8),
                    EntryField(
                        hintText: "Enter your email",
                        controller: _resetemailcontroller),
                    SizedBox(height: 0.02 * ScreenHeight(context)),
                    // const Text("Password",
                    //     style: TextStyle(
                    //         fontFamily: "Inter-reg",
                    //         fontSize: 22,
                    //         color: Colors.white,
                    //         decoration: TextDecoration.none
                    //         )),
                    // const SizedBox(height: 8),
                    // PasswordField(
                    //     hintText: "Enter password",
                    //     controller: _resetpasswordController),

                    
                    const Spacer(),
                    Align(alignment: Alignment.center, child: Bigbutton(label: "Confirm mail", onTap: (){
                      _sendReauthOTP();

                      
                    }))
                    
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
    );
  }
}