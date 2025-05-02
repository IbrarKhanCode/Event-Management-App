import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management_app/Controller/data_controller.dart';
import 'package:event_management_app/View/event_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_management_app/View/Widgets/my_widgets.dart';


class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {


  TextEditingController searchController = TextEditingController();

  DataController dataController = Get.find<DataController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              iconWithTitle(func: () {}, text: 'Community',),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (String input){


                    if(input.isEmpty){
                      dataController.filteredEvents.assignAll(dataController.allEvents);
                    }else{
                      List<DocumentSnapshot> data = dataController.allEvents.value.where((element) {
                        List tags = [];

                        bool isTagContain = false;

                        try {
                          tags = element
                              .get('tags');
                          for(int i=0;i<tags.length;i++){
                            tags[i] = tags[i].toString().toLowerCase();
                            if(tags[i].toString().contains(searchController.text.toLowerCase())){
                              isTagContain = true;

                            }
                          }
                        } catch (e) {
                          tags = [];
                        }
                        return (element.get('location').toString().toLowerCase().contains(searchController.text.toLowerCase())
                            || isTagContain ||
                            element.get('event_name').toString().toLowerCase().contains(searchController.text.toLowerCase())
                        );
                      }).toList();
                      dataController.filteredEvents.assignAll(data);
                    }


                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Container(
                      width: 15,
                      height: 15,
                      padding: EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/search.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    hintText: 'Austin,USA',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Obx(()=> GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.53),
                shrinkWrap: true,
                itemCount: dataController.filteredEvents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {



                  // Initialize variables
                  String userName = '';
                  String userImage = '';
                  String eventUserId = dataController.filteredEvents.value[i].get('uid')?.toString() ?? '';
                  String location = '';
                  String eventImage = '';
                  String tagString = '';
                  String eventName = '';

// Get user document
                  DocumentSnapshot? doc;
                  try {
                    doc = dataController.allUsers.firstWhere(
                          (element) => element.id == eventUserId,
                    );
                  } catch (e) {
                    doc = null;
                  }

// Handle user data
                  if (doc != null) {
                    final data = doc.data() as Map<String, dynamic>;
                    userName = '${data['first'] ?? ''} ${data['last'] ?? ''}'.trim();
                    userImage = data.containsKey('image') ? (data['image']?.toString() ?? '') : '';
                  }


// Handle event data
                  try {
                    final event = dataController.filteredEvents.value[i];
                    location = event.get('location')?.toString() ?? '';
                    eventName = event.get('event_name')?.toString() ?? '';

                    // Handle media
                    try {
                      final media = event.get('media') as List? ?? [];
                      final imageMedia = media.firstWhere(
                            (element) => element is Map && element['isImage'] == true,
                        orElse: () => {'url': ''},
                      );
                      eventImage = imageMedia['url']?.toString() ?? '';
                    } catch (e) {
                      eventImage = '';
                    }

                    // Handle tags
                    final tags = event.get('tags') as List? ?? [];
                    tagString = tags.isEmpty
                        ? event.get('description')?.toString() ?? ''
                        : tags.map((e) => '#$e').join(', ');

                  } catch (e) {
                    // Error handling
                  }


                  return InkWell
                    (
                    onTap: (){
                      
                      Get.to(() => EventPageView(dataController.filteredEvents.value[i], doc!));
                      
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        userProfile(
                          path: userImage,
                          title: userName,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff333333),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/location.png'),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: myText(
                                text: location,

                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff303030),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: 'https://i.pravatar.cc/150?img=10'.isNotEmpty
                              ? Image.network(
                            'https://i.pravatar.cc/150?img=10',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, color: Colors.grey),
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),



                        SizedBox(
                          height: 10,
                        ),
                        myText(
                          text: eventName,

                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        myText(
                          text: tagString,


                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
