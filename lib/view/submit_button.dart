import 'package:flutter/cupertino.dart';
import 'package:tudo_app_with_firebase/view/ui_helper.dart';

import '../const/app_color.dart';
import '../const/app_string.dart';

class SubmitButton extends StatefulWidget {
  SubmitButton({super.key, required this.onPressed, required this.heading});
  final VoidCallback onPressed; // Callback function
  String heading;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    var uiHelper=UiHelper.of(context);
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: uiHelper!.screenWidth*0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primaryColorDarkBlue,
        ),
        child: Center(
          child:  Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.heading,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
