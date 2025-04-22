import 'package:event_management_app/View/Auth/login_and_signup_screen.dart';
import 'package:flutter/material.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(child: Text('Welcome to EMS!',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)),
              Center(child: Text('Event Management System',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),)),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/onboardIcon.png'),
              ),
              SizedBox(height: 80,),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'The Social Media Platform designed to get you '
                          'offline',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                      SizedBox(height: 30,),
                      Text(
                        textAlign: TextAlign.center,
                          'EMS is an app where users can leverage their social network to '
                          'create,discover,share and monetize events and services.'),
                      SizedBox(height: 30,),
                      TextButton(
                          onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginAndSignupScreen()));
                          },
                          child: Text('Get Started',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),))

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
