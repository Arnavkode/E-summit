import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Sign in with email

 Future<AuthResponse> signinwithEmailPassword(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(password: password, email: email);
    if (response.user != null) {
      // Fetch and cache user information
      await fetchUserInfo();
      // Store login state
      var box = Hive.box('userBox');
      box.put('isLoggedIn', true);
    }
    return response;
  }

  //Sign up with email

 Future<AuthResponse> signupwithEmailPassword(String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  // Signout 

 Future<void> signOut(BuildContext context) async {
    await _supabase.auth.signOut();
    Hive.box('userBox').delete('userRollNo');
    Hive.box('userBox').delete('userName');
    Hive.box('userBox').delete('userPhone');
    Hive.box('userBox').delete('userEmail');
    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
  }

  //Get current user mail

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return _supabase.auth.currentUser?.email;
  
  }
  
  // verify OTP
  Future<void> verifyOTP(String token, String email) async {
    try {
      final AuthResponse res = await _supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: token,
        email: email,
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user != null) {
        Fluttertoast.showToast(msg: "OTP verified successfully.");
      } else {
        Fluttertoast.showToast(msg: "OTP verification failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "OTP verification failed: $e");
    }
  }

  Future<void> deleteAccount() async {


    final user = _supabase.auth.currentUser;

    if(user?.id == null){
      Fluttertoast.showToast(msg: "User not found");
      return;
    }
    if (user != null) {
      final response = await _supabase.auth.admin.deleteUser(user.id!);
      
  }
  
}

// Future<int?> insertUser(String name, String phone, String email, String password) async {
//   final supabase = Supabase.instance.client;

//   final response = await supabase
//       .from('users')
//       .insert({
//         'name': name,
//         'phone_no': phone,
//         'email': email,
//         'password_hash' : password,
//       })
//       .select('id') // Select the primary key
//       .single(); // Get only one row

//   if (response != null) {
//     int userId = response['id']; // Get primary key
//     return userId;
//   }

//   return null;
// }

// Future<Map<String, dynamic>?> fetchUserInfo() async {
//     final user = _supabase.auth.currentUser;
//     if (user != null) {
//       try{
//       final response = await _supabase.rpc('fetch_user_info', params: {'email': user.email}).single();
//       return response.map(convert);
//       }catch(e){
//         Fluttertoast.showToast(msg: e.toString());
//       }
//     } else {
//       throw Exception("No user is currently signed in.");
//     }
//   }

 Future<Map<String, dynamic>?> fetchUserInfo() async {
    final user = _supabase.auth.currentUser;

    if (user != null) {
      try {
        final response = await _supabase.rpc('fetch_user_info', params: {'email1': user.email.toString()}).single();
        Fluttertoast.showToast(msg: response.toString());

        var box = Hive.box('userBox');
        box.put('userRollNo', response['roll_no']);
        box.put('userName', response['name']);
        box.put('userPhone', response['phone_no']);

        return response as Map<String, dynamic>;
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        return null;
      }
    } else {
      throw Exception("No user is currently signed in.");
    }
  }

  // Future<void> sendReauthOTP(String email) async {
  //   try {
  //     bool exists = await userExists(email);
  //     if (!exists) {
  //       Fluttertoast.showToast(msg: "User does not exist");
  //       return;
  //     }
  //     await _supabase.auth.resetPasswordForEmail(email);
  //     Fluttertoast.showToast(msg: "OTP sent for reauthentication");
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Failed to send OTP: $e");
  //   }
  // }
  // Future<void> updatePasswordWithOTP(String email, String token, String newPassword) async {
  //   try {
  //     final AuthResponse res = await _supabase.auth.verifyOTP(
  //       type: OtpType.recovery,
  //       token: token,
  //       email: email,
  //     );
  //     final User? user = res.user;

  //     if (user != null) {
  //       await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  //       Fluttertoast.showToast(msg: "Password updated successfully");
  //     } else {
  //       Fluttertoast.showToast(msg: "OTP verification failed");
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Failed to update password: $e");
  //   }
  // }

  Future<void> updatePassword(String newPassword) async {
    try {
      final encryptedPassword = newPassword;
      await _supabase.auth.updateUser(UserAttributes(password: encryptedPassword));
      Fluttertoast.showToast(msg: "Password updated successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to update password: $e");
    }
  }

  Future<bool> userExists(String email) async {
    final response = await _supabase
        .from('users')
        .select('id')
        .eq('email', email)
        .single();

    return response != null;
  }






   Future<bool> checkUserExists(String email) async {
    final response = await _supabase
        .from('users')
        .select('id')
        .eq('email', email).maybeSingle();

    if(response != null){
      return true;
    }
    return false;
    
  }
}



  