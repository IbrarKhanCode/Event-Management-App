import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_management_app/utilis/app_color.dart';
import 'my_widgets.dart';

Widget CustomAppBar(){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        SizedBox(
          width: 116,
          height: 20,
          child: myText(
              text: 'EMS',
              style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,fontSize: 16)),
        ),
        Spacer(),
        SizedBox(
          width: 24,
          height: 22,
          child: InkWell(
            onTap: () {

            },
            child: Image.asset('assets/Frame.png'),
          ),
        ),
        SizedBox(
          width: Get.width * 0.04,
        ),
        InkWell(
          onTap: () {},
          child: SizedBox(
            width: 22,
            height: 20,
            child: Image.asset(
              'assets/menu.png',
            ),
          ),
        ),
      ],
    ),
  );

}
