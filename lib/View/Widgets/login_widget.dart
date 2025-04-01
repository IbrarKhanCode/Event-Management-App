import 'package:event_management_app/Controller/auth_controller.dart';
import 'package:event_management_app/View/Widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  AuthController authController = AuthController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                     hintText: 'ibrarkhan431414@gmail.com',
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
                 Align(
                   alignment: Alignment.centerRight,
                     child: Text('Forgot password?',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),)),
                 SizedBox(height: 20,),
                 PrimaryButton(
                     title: 'Login',
                     onPressed: (){

                       authController.login(email: emailController.text.trim(),password: passwordController.text.trim());

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
                     Container(
                       height: 50,
                       width: 50,
                       decoration: BoxDecoration(
                           color: Colors.teal,
                           borderRadius: BorderRadius.circular(30)
                       ),
                       child: Center(child: Icon(Icons.g_mobiledata,size: 40,color: Colors.white,),),
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
