// ignore_for_file: deprecated_member_use

import 'dart:ffi';

import 'package:e_summit25/pages/welcome_page.dart';
import 'package:e_summit25/services/Auth_services.dart';
import 'package:e_summit25/utils/gloabals.dart';
import 'package:e_summit25/utils/horizontalList.dart';
import 'package:e_summit25/utils/horizontalListdesc.dart';
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoading = false;

  final authservice = Auth();

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
      userName = box.get('userName', defaultValue: '');

      // If user info is not available in cache, fetch from server
      if ((userRoll?.isEmpty ?? true) ||
          (userName?.isEmpty ?? true) ||
          (userPhone?.isEmpty ?? true)) {
        final data = await authservice.fetchUserInfo();
        if (data != null) {
          userName = data['name'] ?? '';
        }
      }

      setState(() {});
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
    return Stack(
      children: [
        Container(
          width: ScreenWidth(context),
          height: ScreenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/UPF.jpg"), // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: ScreenWidth(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(39, 93, 173, 1),
                Color.fromRGBO(18, 18, 18, 0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment(0, -0.5),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Image.asset("lib/assets/images/logo-04.png", height: 80),
            centerTitle: true,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor: const Color.fromARGB(255, 56, 56, 56),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 49,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("lib/assets/images/TVC logo white.png"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Hello, $userName!",
                        style: TextStyle(fontFamily: "Inter", color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded, color: Colors.white),
                  title: const Text("About TVC", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined, color: Colors.white),
                  title: Text("Profile", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                Spacer(),
                ListTile(
                  leading: Icon(Icons.logout_outlined, color: Colors.white),
                  title: Text("Log Out", style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    await authservice.signOut(context);
                    Hive.box('userBox').put('isLoggedIn', false);
                    Fluttertoast.showToast(msg: Hive.box('userBox').get('isLoggedIn').toString());
                    Navigator.pushReplacementNamed(context, '/welcome');
                  },
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.02 * ScreenHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.1 * ScreenWidth(context)),
                  child: const Row(
                    children: [
                      Text(
                        "Upcoming ",
                        style: TextStyle(
                            fontSize: 33,
                            fontFamily: "Inter",
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 33,
                            fontFamily: "Inter",
                            color: Color(0xFF275DAD),
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.02 * ScreenHeight(context),
                ),
                HorizontalImageList(
                  items: events,
                ),
                SizedBox(
                  height: 0.04 * ScreenHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.1 * ScreenWidth(context)),
                  child: const Row(
                    children: [
                      Text(
                        "Mo",
                        style: TextStyle(
                            fontSize: 36,
                            fontFamily: "Inter",
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        "re",
                        style: TextStyle(
                            fontSize: 36,
                            fontFamily: "Inter",
                            color: Color(0xFF275DAD),
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.015 * ScreenHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.075 * ScreenWidth(context)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/map');
                        },
                        child: Container(
                          width: 0.4 * ScreenWidth(context),
                          height: 0.4 * ScreenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1.0,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                const Color(0xffd3c0c0).withOpacity(0.15),
                                const Color(0xff222823).withOpacity(0.15)
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.01 * ScreenHeight(context)),
                            child: const Column(
                              children: [
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Color(0xFF275DAD),
                                      size: 50,
                                    ),
                                    Text(
                                      "Ma",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: "Inter",
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      "p",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: "Inter",
                                          color: Color(0xFF275DAD),
                                          decoration: TextDecoration.none),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0.05 * ScreenWidth(context),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 0.4 * ScreenWidth(context),
                              height: 0.19 * ScreenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color(0xffd3c0c0).withOpacity(0.15),
                                    const Color(0xff222823).withOpacity(0.15)
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: .02 * ScreenWidth(context), bottom: .02 * ScreenWidth(context)),
                                child: const Column(
                                  children: [
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "Live",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Inter",
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              decoration: TextDecoration.none),
                                        ),
                                        Text(
                                          "Stream",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Inter",
                                              color: Color(0xFF275DAD),
                                              decoration: TextDecoration.none),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.02 * ScreenWidth(context),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              launchUrl(Uri.parse("https://online.fliphtml5.com/kkeiv/nmar/#p=1"), mode: LaunchMode.externalApplication);
                            }),
                            child: Container(
                              width: 0.4 * ScreenWidth(context),
                              height: 0.19 * ScreenWidth(context),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: const AssetImage(
                                      "lib/assets/images/sh.png",
                                    ),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8), // Adjust opacity (0.0 - 1.0)
                                      BlendMode.darken,
                                    )),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    const Color(0xffd3c0c0).withOpacity(0.15),
                                    const Color(0xff222823).withOpacity(0.15)
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: .02 * ScreenWidth(context), top: .015 * ScreenWidth(context)),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Startup",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Inter",
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      "Handbook",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Inter",
                                          color: Color(0xFF275DAD),
                                          decoration: TextDecoration.none),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.04 * ScreenHeight(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.1 * ScreenWidth(context)),
                  child: Row(
                    children: [
                      const Text(
                        "Previous ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Inter",
                            color: Color.fromARGB(255, 255, 255, 255),
                            decoration: TextDecoration.none),
                      ),
                      const Text(
                        "Speakers",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Inter",
                            color: Color(0xFF275DAD),
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(height: 0.015 * ScreenHeight(context)),
                    ],
                  ),
                ),
                SizedBox(height: 0.015 * ScreenHeight(context)),
                HorizontalListNormal(items: speakers)
              ],
            ),
          ),
        ),
      ],
    );
  }
}