
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tudo_app_with_firebase/auth/authentication.dart';
import 'package:tudo_app_with_firebase/view/custom_text_field.dart';

import '../const/app_color.dart';
import '../const/app_string.dart';
import '../view/custom_close_button.dart';
import '../view/error_snack.dart';
import '../view/global_function.dart';
import '../view/submit_button.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key, required this.id, required this.event});
  var id;
  QueryDocumentSnapshot event;

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text=widget.event['name'];
    email.text=widget.event['email'];
    mobile.text=widget.event['mobile'];
    print('widget.id');
    print(widget.id);
  }

  var name=TextEditingController();
  var email=TextEditingController();
  var mobile=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Automatically adjusts height
                children: [
                  Center(
                    child:  Text(
                      AppString.add_event,
                      style: TextStyle(
                        color: AppColors.primaryColorDarkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Name',
                      controller: name),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Email',
                      controller: email),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Mobile',
                      controller: mobile,
                      maxLength: 10
                  ),
                  SizedBox(height: 20),
                  SubmitButton(
                    heading: AppString.add_event,
                    onPressed: ()
                    {
                      if(validation())
                        {
                          Authentication.updateEvent(widget.id, name.text.toString(), email.text.toString(), mobile.text.toString(), context);
                        }
                    },)
                ],
              ),
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

  bool validation() {
    if (name.text
        .toString()
        .isEmpty) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_name);
      return false;
    }
    else if (email.text
        .toString()
        .isEmpty) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_email);
      return false;
    }
    else if (!GlobalFunction.isValidEmail(email.text.toString())) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_valid_email);
      return false;
    }
    else if (mobile.text
        .toString()
        .isEmpty) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_mobile);
      return false;
    }
    else if (mobile.text
        .toString()
        .length !=10) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_full_mobile);
      return false;
    }
    else if (!GlobalFunction.isValidMobile(mobile.text.toString())) {
      ErrorSnack.errorSnackBar(context, ValidationString.please_enter_valid_mobile);
      return false;
    }
    return true;
  }

}