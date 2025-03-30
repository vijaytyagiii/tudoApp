import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screen/home_screen/home_screen.dart';
import '../screen/login_screen.dart';

class Authentication
{
  static Future<void> googleLogin(BuildContext context) async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        print("Login Canceled");
        return;
      }
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult = await FirebaseAuth.instance.signInWithCredential(
          credential);

      print("User Logged In: ${result.displayName}");
      print("Email: ${result.email}");
      print("Profile Picture: ${result.photoUrl}");

      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      print("Login Failed: $error");
    }
  }

  static Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance.collection('clients').doc(eventId).delete();
      print("Event deleted successfully!");
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  static Future<void> addEvent(var name, var email, var mobile, BuildContext context) async {
    print('object');
    try {
      CollectionReference collRef= FirebaseFirestore.instance.collection('clients');
      collRef.add({
        'name': name,
        'email': email,
        'mobile': mobile,
        'createdAt': FieldValue.serverTimestamp()
      });

      print("Event added successfully!");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  static Future<void> updateEvent(var id, var name, var email, var mobile, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('clients') // Replace with your collection name
          .doc(id) // Specify document ID
          .update({
        'name': name,
        'email': email,
        'mobile': mobile,
        'updatedAt': FieldValue.serverTimestamp(), // Optional timestamp update
      });

      print("Event updated successfully!");
      Navigator.pop(context);
    } catch (e) {
      print("Error updating event: $e");
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      // Check if the user is signed in with Google
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate to Login Screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );

      print("User logged out successfully!");
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}