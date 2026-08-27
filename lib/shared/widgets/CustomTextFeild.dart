import 'package:flutter/material.dart';

class Customtextfeild extends StatelessWidget {
  final String hinttext;
  final InputDecoration decoration;
  final Widget label;

  const Customtextfeild({super.key, required this.hinttext, this.decoration = const InputDecoration(), this.label = const Text('')});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
body: Center(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            
          ),
        ),
      )


    );
  }
}