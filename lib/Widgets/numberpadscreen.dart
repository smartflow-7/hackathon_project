import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';

class Codescreen extends StatelessWidget {
  const Codescreen({super.key, required this.num});
  final String num;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
          color: Apptheme.mygrey, shape: BoxShape.circle, border: Border()),
      child: Center(
        child: Text(
          num,
          style: const TextStyle(
              fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );
  }
}
