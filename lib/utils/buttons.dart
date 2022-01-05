import 'package:flutter/material.dart';

class Buttons {
  Buttons._();

  static Widget elevatedButton(
      {Function()? onPressed,
      String? text,
      required Size size,
      bool? isOpact}) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1)),
      height: size.height * 0.06,
      width: size.width - 30,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                isOpact ?? false ? Colors.blue.withOpacity(0.5) : Colors.blue,
          ),
          onPressed: onPressed,
          child: Text(
            text!,
            style: TextStyle(fontSize: 20),
          )),
    );
  }
}
