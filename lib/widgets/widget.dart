import 'package:flutter/material.dart';

Widget appBar(BuildContext context, String text1, String text2) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 27),
      children: <TextSpan>[
        TextSpan(
            text: text1,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        TextSpan(
            text: text2,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan)),
      ],
    ),
  );
}

Widget blueButton(BuildContext context, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
