// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../utils/Datas.dart';

class welcome_page extends StatefulWidget {
  const welcome_page({super.key});

  @override
  State<welcome_page> createState() => _welcome_pageState();
}

class _welcome_pageState extends State<welcome_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [

         
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
                    
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                    
              children: [
                SizedBox(height: 0.35*ScreenHeight(context),),
                // Row(
                  
                //   children: [
                //     SizedBox(width: 0.25*ScreenWidth(context),),
                //     Image.asset("lib/assets/images/TVC logo white.png", height: 50,),
                //     Text("Thapar Venture Club", style: TextStyle(color: Colors.white),)
                //   ],
                // ),
                Image.asset("lib/assets/images/logo-04.png"),
                SizedBox(height: 0.15*ScreenHeight(context),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 250 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: Color.fromRGBO(39, 93, 173, 1),
                    ),
                    
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.white,
                        fontSize: 21
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text("Create a new account.",
                  
                  style: basic()),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment(0, 0*45*ScreenHeight(context)),
                    child: Text("By continuing, you accept Terms & Conditions",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 10,
                      color: Colors.white
                    ),),
                    ),
                )
                    
              ],
            ),
              
            ),
            Positioned(
          top: 0,
          left: 0,
          right: 0,
           child: AppBar(
                   backgroundColor: Colors.transparent,
                   elevation: 0,
                   actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 0.05*ScreenWidth(context)),
                      child: Row(
                        children: [
                          Text("Admin",
                          style: basic(),),
                          Icon(Icons.arrow_forward_ios, color: Colors.white,)
                        ],
                      ),
                    
                    
                    )
                   ],
                   
                   
                 ),
         ),
          ],
      ),
    );
  }
}