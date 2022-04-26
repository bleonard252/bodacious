import 'package:bodacious/main.dart';
import "package:flutter/material.dart";

class ErrorListView extends StatelessWidget {
  const ErrorListView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: [
        for (final error in errors.values) ListTile(
          textColor: Colors.red,
          title: Text(error),
        )
      ])
      
    );
  }
}