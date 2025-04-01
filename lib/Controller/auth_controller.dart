import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management_app/View/Profile/profile_screen.dart';
import 'package:event_management_app/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;



  void login({String? email, String? password}) {


    auth.signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {

      Get.to(HomeScreen());
    }).catchError((e) {

      Get.snackbar('Error', "$e");

    });
  }

  void signUp({String? email, String? password}) {




    auth.createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {

          Get.to(ProfileScreen());

    }).catchError((e) {

     Get.snackbar('Error', "$e");

    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('Email Sent', 'We have sent password reset email');
    }).catchError((e) {
      Get.snackbar('Error', "$e");
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



      // Get.to(() => BottomBarView());
    }).catchError((e) {

      Get.snackbar('Error', "$e");
    });
  }


  var isProfileInformationLoading = false.obs;

  Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = path.basename(image.path);

    var reference =
    FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      Get.snackbar('Error', "$e");
    });

    return imageUrl;
  }




  uploadProfileData(String imageUrl, String firstName, String lastName,
      String mobileNumber, String dob, String gender) {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': imageUrl,
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender
    }).then((value) {
      isProfileInformationLoading(false);
      // Get.offAll(()=> BottomBarView());
    });

  }
}