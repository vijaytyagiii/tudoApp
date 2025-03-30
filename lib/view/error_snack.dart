import 'package:flutter/material.dart';

class ErrorSnack
{
  static errorSnackBar(BuildContext context, String message){
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(// Position from the bottom
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                // borderRadius: BorderRadius.circular(10.0), // Set the border radius here
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the custom toast after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}