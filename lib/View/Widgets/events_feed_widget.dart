import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management_app/Controller/data_controller.dart';
import 'package:event_management_app/View/Profile/profile_screen.dart';
import 'package:event_management_app/View/event_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_management_app/Model/ticket_model.dart';
import 'package:event_management_app/utilis/app_color.dart';


List<AustinYogaWork> austin = [
  AustinYogaWork(rangeText: '7-8', title: 'CONCERN'),
  AustinYogaWork(rangeText: '8-9', title: 'VINYASA'),
  AustinYogaWork(rangeText: '9-10', title: 'MEDITATION'),
];
List<String> imageList = [
  'assets/#1.png',
  'assets/#2.png',
  'assets/#3.png',
  'assets/#1.png',
];

Widget EventsFeed() {
  final DataController dataController = Get.find<DataController>();

  return Obx(() => dataController.isEventsLoading.value
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (ctx, i) {
      return EventItem(dataController.allEvents[i]);
    },
    itemCount: dataController.allEvents.length,
  ));
}

Widget buildCard({String? image, String? text, Function? func, DocumentSnapshot? eventData}) {
  final DataController dataController = Get.find<DataController>();

  List joinedUsers = [];
  List userLikes = [];
  List eventSavedByUsers = [];
  List dateInformation = [];
  int comments = 0;

  try {
    joinedUsers = eventData?.get('joined') ?? [];
    dateInformation = eventData?.get('date')?.toString().split('-') ?? [];
    userLikes = eventData?.get('likes') ?? [];
    comments = eventData?.get('comments')?.length ?? 0;
    eventSavedByUsers = eventData?.get('saves') ?? [];
  } catch (e) {
    // Fallbacks already handled
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff393939),
          spreadRadius: 0.1,
          blurRadius: 2,
          offset: Offset(0, 0),
        ),
      ],
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Force the InkWell to show up
          InkWell(
            onTap: () {
              print('Tapped!');
              func?.call();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/300"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: Get.width * 0.5,
            ),
          ),



        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 41,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xffADD8E6)),
                ),
                child: Text(
                  (dateInformation.length >= 2) ? '${dateInformation[0]}-${dateInformation[1]}' : 'Date',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  text ?? 'Event Name',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () {
                  final uid = FirebaseAuth.instance.currentUser?.uid;
                  if (uid != null && eventData != null) {
                    final update = eventSavedByUsers.contains(uid)
                        ? FieldValue.arrayRemove([uid])
                        : FieldValue.arrayUnion([uid]);
                    FirebaseFirestore.instance.collection('events').doc(eventData.id).set(
                      {'saves': update},
                      SetOptions(merge: true),
                    );
                  }
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/boomMark.png',
                    fit: BoxFit.contain,
                    color: eventSavedByUsers.contains(FirebaseAuth.instance.currentUser?.uid) ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Joined Users Avatars
        if (joinedUsers.isNotEmpty)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: joinedUsers.length,
              itemBuilder: (ctx, index) {
                try {
                  final user = dataController.allUsers.firstWhere((e) => e.id == joinedUsers[index]);
                  final userImage = user.get('image')?.toString() ?? '';

                  return Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      minRadius: 13,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: (userImage.isNotEmpty) ? NetworkImage(userImage) : null,
                      child: (userImage.isEmpty) ? const Icon(Icons.person, size: 15) : null,
                    ),
                  );
                } catch (e) {
                  return const SizedBox();
                }
              },
            ),
          ),

        const SizedBox(height: 15),

        // Likes, Comments, Share
        Row(
          children: [
            const SizedBox(width: 68),
            InkWell(
              onTap: () {
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid != null && eventData != null) {
                  final update = userLikes.contains(uid)
                      ? FieldValue.arrayRemove([uid])
                      : FieldValue.arrayUnion([uid]);
                  FirebaseFirestore.instance.collection('events').doc(eventData.id).set(
                    {'likes': update},
                    SetOptions(merge: true),
                  );
                }
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Color(0xffD24698)),
                  ],
                ),
                child: Icon(
                  Icons.favorite,
                  size: 14,
                  color: userLikes.contains(FirebaseAuth.instance.currentUser?.uid) ? Colors.red : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Text(
              '${userLikes.length}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(0.5),
              width: 17,
              height: 17,
              child: Image.asset(
                'assets/message.png',
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '$comments',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(0.5),
              width: 16,
              height: 16,
              child: Image.asset(
                'assets/send.png',
                fit: BoxFit.contain,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


Widget EventItem(DocumentSnapshot event) {
  final DataController dataController = Get.find<DataController>();

  DocumentSnapshot? user;
  String? userImage;
  String eventImage = '';
  String userName = 'User';

  try {
    user = dataController.allUsers.firstWhere(
          (e) => e.id == event.get('uid'),
      orElse: () => throw Exception('User not found'),
    );

    userImage = user.get('image')?.toString();
    if (userImage == null || userImage.isEmpty) {
      userImage = null;
    }

    final first = user.get('first')?.toString() ?? '';
    final last = user.get('last')?.toString() ?? '';
    userName = ('$first $last').trim();
    if (userName.isEmpty) userName = 'User';
  } catch (e) {
    userImage = null;
    userName = 'User';
  }

  try {
    final media = event.get('media') as List? ?? [];
    final mediaItem = media.firstWhere(
          (e) => e['isImage'] == true && (e['url']?.toString().isNotEmpty ?? false),
      orElse: () => null,
    );
    eventImage = mediaItem?['url']?.toString() ?? '';
  } catch (e) {
    eventImage = '';
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          InkWell(
            onTap: () => Get.to(() => ProfileScreen()),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: userImage != null ? NetworkImage(userImage) : null,
              child: userImage == null
                  ? Icon(Icons.person, color: Colors.grey)
                  : null,
            ),
          ),
          SizedBox(width: 12),
          Text(
            userName,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
      SizedBox(height: Get.height * 0.015),
      buildCard(
        image: eventImage,
        text: event.get('event_name')?.toString() ?? 'Event',
        eventData: event,
          func: () {
            if (event != null && user != null) {
              Get.to(() => EventPageView(event!, user!));
            }
          }
      ),
      SizedBox(height: 15),
    ],
  );
}


Widget EventsIJoined() {
  final DataController dataController = Get.find<DataController>();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  // Safe user data retrieval
  late DocumentSnapshot myUser;
  try {
    myUser = dataController.allUsers.firstWhere(
          (e) => e.id == currentUserId,
      orElse: () => throw Exception('User not found'),
    );
  } catch (e) {
    return _buildErrorWidget('Error loading user data');
  }

  // Safe image URL retrieval
  String? userImage;
  try {
    userImage = myUser.get('image')?.toString();
    if (userImage == null || userImage.isEmpty) {
      userImage = null;
    }
  } catch (e) {
    userImage = null;
  }

  // Safe name retrieval
  String userName = 'User';
  try {
    final first = myUser.get('first')?.toString() ?? '';
    final last = myUser.get('last')?.toString() ?? '';
    userName = '$first $last'.trim();
    if (userName.isEmpty) {
      userName = 'User';
    }
  } catch (e) {
    userName = 'User';
  }

  return Column(
    children: [
      _buildHeaderSection(),
      SizedBox(height: Get.height * 0.015),
      _buildEventsList(dataController, userName, userImage),
      SizedBox(height: 20),
    ],
  );
}

Widget _buildHeaderSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(10),
        child: Image.asset(
          'assets/doneCircle.png',
          fit: BoxFit.cover,
          color: AppColors.blue,
        ),
      ),
      SizedBox(width: 15),
      Text(
        'You\'re all caught up!',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget _buildEventsList(DataController dataController, String userName, String? userImage) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade50,
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, 1),
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.all(10),
    width: double.infinity,
    child: Column(
      children: [
        _buildUserProfileRow(userName, userImage),
        Divider(color: Color(0xff918F8F)),
        Obx(() => dataController.isEventsLoading.value
            ? Center(child: CircularProgressIndicator())
            : _buildEventsListView(dataController)),
      ],
    ),
  );
}

Widget _buildUserProfileRow(String userName, String? userImage) {
  return Row(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: userImage != null && userImage.isNotEmpty
            ? NetworkImage(userImage)
            : null,
        child: (userImage == null || userImage.isEmpty)
            ? Icon(Icons.person, color: Colors.grey)
            : null,
      ),
      SizedBox(width: 10),
      Text(
        userName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget _buildEventsListView(DataController dataController) {
  if (dataController.joinedEvents.isEmpty) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text('No events joined yet'),
    );
  }

  return ListView.builder(
    itemCount: dataController.joinedEvents.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, i) {
      try {
        final event = dataController.joinedEvents[i];
        final name = event.get('event_name') ?? 'Unnamed Event';
        final date = _formatEventDate(event.get('date'));
        final joinedUsers = event.get('joined') as List? ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildDateBadge(date),
                  SizedBox(width: Get.width * 0.06),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildJoinedUsersAvatars(dataController, joinedUsers),
          ],
        );
      } catch (e) {
        return SizedBox(); // Silently skip malformed events
      }
    },
  );
}

Widget _buildDateBadge(String date) {
  return Container(
    width: 41,
    height: 24,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Color(0xffADD8E6)),
    ),
    child: Text(
      date,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
  );
}

Widget _buildJoinedUsersAvatars(DataController dataController, List joinedUsers) {
  if (joinedUsers.isEmpty) {
    return SizedBox(height: 10);
  }

  return SizedBox(
    width: Get.width * 0.6,
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: joinedUsers.length,
      itemBuilder: (ctx, index) {
        try {
          final userId = joinedUsers[index];
          final user = dataController.allUsers.firstWhere(
                (e) => e.id == userId,
            orElse: () => throw Exception('User not found'),
          );

          String? image;
          try {
            image = user.get('image')?.toString();
            if (image == null || image.isEmpty) {
              image = null;
            }
          } catch (e) {
            image = null;
          }

          return Container(
            margin: EdgeInsets.only(left: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : null,
              child: (image == null)
                  ? Icon(Icons.person, size: 18, color: Colors.grey)
                  : null,
            ),
          );
        } catch (e) {
          // If user not found or error happens, skip showing anything
          return SizedBox();
        }
      },
    ),
  );
}

String _formatEventDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '--';

  try {
    final parts = dateString.split('-');
    if (parts.length >= 2) {
      return '${parts[0]}-${parts[1]}';
    }
    return dateString;
  } catch (e) {
    return '--';
  }
}

Widget _buildErrorWidget(String message) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}
