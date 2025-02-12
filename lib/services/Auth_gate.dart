// listen for auth state changes
// authenticated -> show dashboard
// unauthenticated -> show welcome page

import 'package:e_summit25/pages/dashboard.dart';
import 'package:e_summit25/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.hasData){
            return const Dashboard();
          }else{
            return const welcome_page();
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      );
  }
}

