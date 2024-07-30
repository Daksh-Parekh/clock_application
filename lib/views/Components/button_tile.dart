import 'package:flutter/material.dart';

Widget ButtonTile({String title = "Normal", required Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title Button"),
        child,
      ],
    ),
  );
}