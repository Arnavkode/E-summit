import 'dart:async';

import 'package:e_summit25/pages/Bizconclave.dart';
import 'package:e_summit25/pages/IF.dart';
import 'package:e_summit25/pages/Networkingcarnival.dart';
import 'package:e_summit25/pages/New_password.dart';
import 'package:e_summit25/pages/OTP_page.dart';
import 'package:e_summit25/off%20pages/OTP_reauth.dart';
import 'package:e_summit25/pages/account_page.dart';
import 'package:e_summit25/pages/dashboard.dart';
import 'package:e_summit25/pages/opening_ceremony.dart';
import 'package:e_summit25/pages/unwind.dart';
import 'package:e_summit25/pages/login_page.dart';
import 'package:e_summit25/off%20pages/Reset_password.dart';
import 'package:e_summit25/pages/signup_page.dart';
import 'package:e_summit25/pages/splash_screen.dart';
import 'package:e_summit25/pages/welcome_page.dart';
import 'package:e_summit25/pages/ytconnect.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y3hvYmhlYm9taXFuZXRqbnlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NTAzMTcsImV4cCI6MjA1NDQyNjMxN30.H__ZEDMKPc_oZY2QcnnO8-bTTtMfrEzE-VsZHKJpxn8",
    url: "https://pzcxobhebomiqnetjnys.supabase.co",
  );
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  
// @override
//   Widget build(BuildContext context) {
//     final GoRouter _router = GoRouter(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => SplashScreen(),
//         ),
//         GoRoute(
//           path: '/welcome',
//           builder: (context, state) => const welcome_page(),
//         ),
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginPage(),
//         ),
//         GoRoute(
//           path: '/signup',
//           builder: (context, state) => const SignupPage(),
//         ),
//         GoRoute(
//           path: '/dashboard',
//           builder: (context, state) => const Dashboard(),
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) => AccountPage(),
//         ),
//         GoRoute(
//           path: '/otppage',
//           builder: (context, state) => MyVerify(),
//         ),
//         GoRoute(
//           path: '/reset',
//           builder: (context, state) => ResetPage(),
//         ),
//         GoRoute(
//           path: '/newpass',
//           builder: (context, state) => NewPassword(),
//         ),
//         GoRoute(
//           path: '/reauth',
//           builder: (context, state) => OTPreauth(),
//         ),
//       ],
//     );

//     return MaterialApp.router(
//       routerConfig: _router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => const welcome_page(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/dashboard': (context) => const Dashboard(),
        '/profile': (context) => AccountPage(),
        '/otppage': (context) => MyVerify(),
        '/reset': (context) => ResetPage(),
        '/newpass': (context) => NewPassword(),
        '/reauth': (context) => OTPreauth(),
        '/unwind': (context) => Unwind(),
        '/internshipfair': (context) => InternshipFair(),
        '/youtubeconnect' : (context) => YTconnect(),
        '/openingcer' : (context) => OpeningCeremony(),
        '/networking' : (context) => Networkingcarnival(),
        '/bizconclave' : (context) => Bizconclave()
      },
      debugShowCheckedModeBanner: false,
      // home:  welcome_page()
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
