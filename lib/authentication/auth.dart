import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static String message = "";
  static bool status = false;
  // static Set<String> phone_set = HashSet<String>();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> register(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      message = "Signup successful";
      return true;
    } catch (e) {
      message = e.toString();
      print(message);
      switch (message) {
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          message = "The email address is badly formatted.";
          break;

        case "An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]":
          message = "Invalid credentials";
          break;

        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          message = "E-mail already in use";
          break;

        case "[firebase_auth/weak-password] Password should be at least 6 characters":
          message = "Password should be at least 6 characters";
          break;

        default:
          message = "Internal error";
      }
      //  message= message.substring(message.indexOf(']') + 1);
      print(message);
      return false;
    }
  }

  Future<bool> login(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      message = "Sigin successful";
      return true;
    } catch (e) {
      message = e.toString();
      print(message);
      switch (message) {
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          message = "The email address is badly formatted.";
          break;

        case "[firebase_auth/INVALID_LOGIN_CREDENTIALS] An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]":
          message = "Invalid login credentials";
          break;

        default:
          message = "Internal error";
      }
      print(message);
      return false;
    }
  }

  static Future<void> logout() async {
    print(FirebaseAuth.instance.currentUser!.email);
    await FirebaseAuth.instance.signOut();
    print("log out successful");
  }
}
