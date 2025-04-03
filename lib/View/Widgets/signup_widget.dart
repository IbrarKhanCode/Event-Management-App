import 'package:event_management_app/Controller/auth_controller.dart';
import 'package:event_management_app/View/Widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {

  AuthController authController = AuthController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                          prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,size: 20,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.teal)
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                          prefixIcon: Icon(Icons.lock_open,color: Colors.grey,size: 20,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.teal)
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: confirmController,
                      decoration: InputDecoration(
                          hintText: 'Re-enter password',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                          prefixIcon: Icon(Icons.lock_open,color: Colors.grey,size: 20,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.teal)
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    PrimaryButton(
                        title: 'Sign Up',
                        onPressed: (){

                          authController.signUp(email: emailController.text.trim(),password: passwordController.text.trim());

                        }
                    ),
                    SizedBox(height: 50,),
                    Text('Or connect with',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Icon(Icons.facebook,size: 30,color: Colors.white,),),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            authController.signInWithGoogle();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(child: Icon(Icons.g_mobiledata,size: 40,color: Colors.white,),),
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
