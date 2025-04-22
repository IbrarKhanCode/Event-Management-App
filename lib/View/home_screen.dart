import 'package:event_management_app/Controller/data_controller.dart';
import 'package:event_management_app/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_management_app/View/Widgets/events_feed_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
 }

class _HomeScreenState extends State<HomeScreen> {

  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomAppBar(),

                Text(
                  "What Going on today",
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                EventsFeed(),
                Obx(()=> dataController.isUsersLoading.value? Center(child: CircularProgressIndicator(),) : EventsIJoined()),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
