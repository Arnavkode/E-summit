// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/gloabals.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class Profile {
  final name = null;
  final rollnum = null;
  final phonenum = null;
}

class _AccountPageState extends State<AccountPage> {
  final authservice = Auth();
  bool _isLoading = false;
  Map<String, dynamic>? userInfo;

  void deleteAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authservice.deleteAccount();
      Fluttertoast.showToast(msg: "Account deleted successfully");
      Navigator.pushReplacementNamed(context, '/welcome');
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
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var box = Hive.box('userBox');
      userRoll = box.get('userRollNo', defaultValue: '');
      userName = box.get('userName', defaultValue: '');
      userPhone = box.get('userPhone', defaultValue: '');

      // If user info is not available in cache, fetch from server
      if ((userRoll?.isEmpty ?? true) || (userName?.isEmpty ?? true) || (userPhone?.isEmpty ?? true)) {
        final data = await authservice.fetchUserInfo();
        if (data != null) {
          userRoll = data['roll_no'] ?? '';
          userName = data['name'] ?? '';
          userPhone = data['phone_no'] ?? '';
        }
      }

      setState(() {});
      Fluttertoast.showToast(msg: userName ?? 'No name available');
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            width: ScreenWidth(context),
            height: ScreenHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/UPF.jpg"), // Replace with your placeholder image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  width: ScreenWidth(context),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(39, 93, 173, 0.5), // Adjust opacity
                        Color.fromRGBO(18, 18, 18, 0.3) // Adjust opacity
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment(0, -0.5),
                    ),
                  ),
                ),
                Container(
                  width: 412,
                  height: 917,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Color(0xFF121212).withOpacity(0.7), // Adjust opacity
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -0.07 * ScreenHeight(context),
                        top: -0.55 * ScreenWidth(context),
                        child: Container(
                          width: 0.6 * ScreenHeight(context),
                          height: 0.6 * ScreenHeight(context),
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0x7F275DAD), Color(0xFF5777A6)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, -0.5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: AssetImage('lib/assets/images/tanu.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0.1 * ScreenWidth(context),
                          top: 0.45 * ScreenHeight(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 28,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              height: 0.01 * ScreenHeight(context),
                            ),
                            Container(
                              height: 0.075 * ScreenHeight(context),
                              width: 0.8 * ScreenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ), // White border with 2px width
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 0.02 * ScreenHeight(context)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    userName ?? "No name",
                                    style: TextStyle(
                                      fontFamily: "Inter-r",
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 0.03 * ScreenHeight(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.02 * ScreenHeight(context),
                            ),
                            Text(
                              "Roll no.",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 28,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              height: 0.01 * ScreenHeight(context),
                            ),
                            Container(
                              height: 0.075 * ScreenHeight(context),
                              width: 0.8 * ScreenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ), // White border with 2px width
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 0.02 * ScreenHeight(context)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    userRoll ?? "No roll number",
                                    style: TextStyle(
                                      fontFamily: "Inter-r",
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 0.03 * ScreenHeight(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.02 * ScreenHeight(context),
                            ),
                            Text(
                              "Phone number",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 28,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              height: 0.01 * ScreenHeight(context),
                            ),
                            Container(
                              height: 0.075 * ScreenHeight(context),
                              width: 0.8 * ScreenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ), // White border with 2px width
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 0.02 * ScreenHeight(context)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    userPhone ?? "No phone number",
                                    style: TextStyle(
                                      fontFamily: "Inter-r",
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 0.03 * ScreenHeight(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}