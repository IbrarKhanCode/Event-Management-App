import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management_app/View/Bottom%20bar/bottom_bar_view.dart';
import 'package:event_management_app/View/Profile/add_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;



  void login({String? email, String? password}) {


    auth.signInWithEmailAndPassword(email: email!, password: password!)
        .then((value){
          Get.to(BottomBarView());
    }).onError((e,stackTrace){
       Get.snackbar('Error', e.toString(),backgroundColor: Colors.red,colorText: Colors.white,duration: Duration(seconds: 1));
    });
  }

  void signUp({String? email, String? password}) {

    auth.createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {

          Get.to(AddProfileScreen());

    }).onError((e,stackTrace){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.red,colorText: Colors.white,duration: Duration(seconds: 1));
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('Email Sent', 'We have sent password to reset email');
    }).onError((e,stackTrace){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.red,colorText: Colors.white,duration: Duration(seconds: 1));
    });
  }

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut(); // clears Firebase session

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      Get.snackbar('Cancelled', 'Sign-in aborted by user',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Get.to(BottomBarView());
    }).onError((e, stackTrace) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }




  uploadProfileData(String firstName, String lastName,
      String mobileNumber, String dob, String gender) {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender
    }).then((value) {
      Get.offAll(BottomBarView());
    });

  }
}