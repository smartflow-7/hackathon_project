import 'package:flutter/material.dart';
import 'package:hackathon_project/components/Apptheme.dart';

class Onboardbuttons extends StatelessWidget {
  const Onboardbuttons(
      {super.key, required this.index, required this.buttonindex});
  final int index;
  final int buttonindex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 17.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: buttonindex == index + 1 ? Apptheme.primary : Apptheme.grey,
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$buttonindex',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
              color: buttonindex == index + 1 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
