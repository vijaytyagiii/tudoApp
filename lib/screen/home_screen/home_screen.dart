import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tudo_app_with_firebase/alert/add_event.dart';
import 'package:tudo_app_with_firebase/const/app_color.dart';
import 'package:tudo_app_with_firebase/screen/home_screen/home_screen_controller.dart';
import 'package:tudo_app_with_firebase/const/app_string.dart';
import '../../alert/edit_event.dart';
import 'package:intl/intl.dart';

import '../../auth/authentication.dart';
import '../../view/side_menu.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String searchQuery = "";
  
  HomeScreenController _homeScreenController=Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: SideMenu(),
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(AppString.dashboard),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  _homeScreenController.setData(value);
                },
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('clients').orderBy('createdAt', descending: false).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Lottie.asset(
                    'assets/images/data_not_found.json',
                    // width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ));
                }

                return Obx(() {
                  var events = snapshot.data!.docs.where((doc) {
                    var eventData = doc.data() as Map<String, dynamic>;
                    return eventData['name'].toString().toLowerCase().contains(_homeScreenController.searchQuery.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      var eventData = events[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name'),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Text(
                                            eventData['name'] != null
                                                ? eventData['name']
                                                : "",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Email'),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Text(
                                            eventData['email'] != null
                                                ? eventData['email']
                                                : "",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(eventData['updatedAt'] != null
                                            ? 'updatedAt'
                                            : 'createdAt'
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Text(
                                            eventData['updatedAt'] != null
                                                ? DateFormat('dd-MM-yyyy hh:mm')
                                                .format((eventData['updatedAt'] as Timestamp).toDate())
                                                : eventData['createdAt'] != null
                                                ? DateFormat('dd-MM-yyyy hh:mm')
                                                .format((eventData['createdAt'] as Timestamp).toDate())
                                                : "",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Status'),
                                        SizedBox(width: 20),
                                        Spacer(),
                                        Icon(Icons.check, color: Colors.green, size: 20,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(eventData['updatedAt'] != null
                                              ? '(Edit)'
                                              : '(Add)',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(context: context, builder: (context) => EditEvent(id: snapshot.data!.docs[index].id, event: snapshot.data!.docs[index]));
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7.5)),
                                          color: AppColors.primaryColorDarkBlue,
                                        ),
                                        child: Center(child: Text('Edit', style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Authentication.deleteEvent(snapshot.data!.docs[index].id);
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomRight : Radius.circular(7.5)),
                                            color: AppColors.primaryColorDarkBlue50,
                                        ),
                                        child: Center(child: Text('Delete', style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },);
              },
            ),
          ),
        ],
      )
    );
  }
}
