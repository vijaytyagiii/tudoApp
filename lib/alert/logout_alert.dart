import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tudo_app_with_firebase/auth/authentication.dart';
import 'package:tudo_app_with_firebase/view/ui_helper.dart';

import '../screen/login_screen.dart';
import '../const/app_color.dart';
import '../const/app_string.dart';
import '../view/custom_close_button.dart';

class LogoutAlert extends StatefulWidget {
  const LogoutAlert({super.key});

  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  @override
  @override
  Widget build(BuildContext context) {
    var uiHelper = UiHelper.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            width: uiHelper!.screenWidth * 0.7, // Set width to 80% of screen width
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust height dynamically
              children: [
                Text(
                  AppString.logout,
                  style: TextStyle(
                    color: AppColors.primaryColorDarkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppString.are_you_sure}?',
                  style: TextStyle(
                    color: AppColors.primaryColorDarkBlue,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '${AppString.please_confirm_if_you_want_to_logout}.',
                  style: TextStyle(
                    color: AppColors.black54,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 35,
                        width: uiHelper.screenWidth*0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.primaryColorDarkBlue),
                          color: AppColors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.primaryColorDarkBlue),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Authentication.logout(context);
                      },
                      child: Container(
                        height: 35,
                        width: uiHelper.screenWidth*0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.primaryColorDarkBlue),
                          color: AppColors.primaryColorDarkBlue,
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: CustomCloseButton()
          )
        ],
      ),
    );
  }
}