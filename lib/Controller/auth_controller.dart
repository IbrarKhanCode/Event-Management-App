import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management_app/View/Profile/add_profile_screen.dart';
import 'package:event_management_app/View/Profile/profile_screen.dart';
import 'package:event_management_app/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;



  void login({String? email, String? password}) {


    auth.signInWithEmailAndPassword(email: email!, password: password!)
        .then((value){
          Get.to(HomeScreen());
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

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {

      Get.to(HomeScreen());
    }).onError((e,stackTrace){
      Get.snackbar('Error', e.toString(),backgroundColor: Colors.red,colorText: Colors.white,duration: Duration(seconds: 1));
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
      Get.to(ProfileScreen());
    });

  }
}