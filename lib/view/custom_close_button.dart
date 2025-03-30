import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCloseButton extends StatefulWidget {
  const CustomCloseButton({super.key});

  @override
  State<CustomCloseButton> createState() => _CustomCloseButtonState();
}

class _CustomCloseButtonState extends State<CustomCloseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        // widget.closeButton(true);
        Navigator.pop(context);
      },
      child: CircleAvatar(
          radius: 12,
          backgroundColor: Colors.black12,
          child: Icon(Icons.close,color: Colors.black45,size: 18,)
      ),
    );
  }
}
