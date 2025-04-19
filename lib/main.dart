import 'package:event_management_app/Controller/auth_controller.dart';
import 'package:event_management_app/Controller/data_controller.dart';
import 'package:event_management_app/View/Bottom%20bar/bottom_bar_view.dart';
import 'package:event_management_app/View/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  Get.put(DataController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser!.uid == null ? OnboardingScreen() : BottomBarView(),
    );
  }
}
