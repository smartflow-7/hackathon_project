import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';

class TimeButtons extends StatelessWidget {
  const TimeButtons(
      {super.key,
      required this.index,
      required this.buttonindex,
      required this.onTap});
  final String index;
  final String buttonindex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 17.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: buttonindex == index
                ? Apptheme.primary
                : themecolor.primaryContainer,
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            buttonindex,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
              color: buttonindex == index
                  ? themecolor.inversePrimary
                  : themecolor.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
