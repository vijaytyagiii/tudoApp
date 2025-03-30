import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tudo_app_with_firebase/const/app_color.dart';
import 'package:tudo_app_with_firebase/const/app_string.dart';
import 'package:tudo_app_with_firebase/view/ui_helper.dart';

import '../auth/authentication.dart';
import 'home_screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var uiHelpre = UiHelper.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // color: Colors.grey,
            height: uiHelpre!.screenHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.welcome_to_todo_app,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildFeatureText(
                      title: AppString.seamless_login_and_register,
                      description: AppString.sign_in_securely_with_google_and_manage_your_tasks_effortlessly,
                    ),
                    buildFeatureText(
                      title: AppString.manage_your_tasks,
                      description: AppString.add_edit_delete_and_categorize_your_todos_easily,
                    ),
                    buildFeatureText(
                      title: AppString.live_search_and_filtering,
                      description: AppString.find_your_tasks_instantly_with_real_time_search,
                    ),
                    buildFeatureText(
                      title: AppString.stay_logged_in,
                      description: AppString.your_session_is_saved_open_the_app_and_continue_from_where_you_left_off,
                    ),
                    // Spacer(),
                    SizedBox(height: uiHelpre.screenHeight*0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: uiHelpre.screenHeight*0.1,
            child: Container(
              height: 50,
              // color: Colors.grey,
              width: uiHelpre.screenWidth,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Authentication.googleLogin(context);
                  },
                  child: Container(
                    width: uiHelpre.screenWidth*0.7,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColorDarkBlue
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.sign_in, style: TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                              'assets/images/google_icon.png',
                            height: 40,
                            width: 40
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildFeatureText({required String title, required String description}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(description, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    ),
  );
}