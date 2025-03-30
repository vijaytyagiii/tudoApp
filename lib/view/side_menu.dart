import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tudo_app_with_firebase/alert/add_event.dart';
import 'package:tudo_app_with_firebase/alert/logout_alert.dart';
import 'package:tudo_app_with_firebase/screen/login_screen.dart';

import 'custom_close_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('SideMenu');
    user = FirebaseAuth.instance.currentUser;
    print(user?.displayName);
    print(user?.email);
    print(user?.phoneNumber);
  }
  User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width-40,
        height: double.infinity,
        child: Drawer(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage('assets/images/header_1.png'))
                      ),
                      child:  Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        imageUrl: '${user?.photoURL ?? ''}',
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => const CircleAvatar(
                                            backgroundColor:Colors.white,
                                            child: Icon(CupertinoIcons.person)),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${user?.displayName ?? ''}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 1),
                                      Text('${user?.email ?? ''}',style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 1),
                                      Text('${user?.phoneNumber ?? ''}',style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 1),
                                    ],
                                  ),
                                )

                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Colors.black45),
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                showDialog(context: context, builder: (context) => AddEvent(),);
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: -4),
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 20),
                                      SizedBox(width: 20),
                                      Text('Add Event',
                                          style: TextStyle(color: Colors.black, fontSize: 15)),
                                    ],
                                  ),
                                  Icon(Icons.keyboard_arrow_right_sharp),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black45,
                              thickness: 0.2,
                            ),
                            ListTile(
                              onTap: () {
                                showDialog(context: context, builder: (context) => LogoutAlert());
                                // logout();
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: -4),
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.logout, size: 20),
                                      SizedBox(width: 20),
                                      Text('LogOut',
                                          style: TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                  Icon(Icons.keyboard_arrow_right_sharp),
                                ],
                              ),
                            ),
                            SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
              Positioned(
                top: 5,
                left: 5,
                child: CustomCloseButton()
              )
    ]
      ),
    )
    ));
  }
}
