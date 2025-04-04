import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  const PrimaryButton({super.key,required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
      ),
    );
  }
}
