// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../utils/template.dart';

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
                    
              children: [
                SizedBox(height: 0.75*ScreenHeight(context),),
                Container(
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
                SizedBox(height: 10,),
                Text("Create a new account.",
                
                style: basic()),

                Expanded(
                  child: Align(
                    child: Text("By continuing, you accept Terms & Conditions",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 10,
                      color: Colors.white
                    ),),
                    alignment: Alignment(0, 0*45*ScreenHeight(context)),
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