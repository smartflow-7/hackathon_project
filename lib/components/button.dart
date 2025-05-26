// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hackathon_project/components/apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Mybutton extends StatelessWidget {
  final myColor;
  final textcolor;
  final String Buttontext;
  final clicked;
  final buttonsize;

  const Mybutton(
      {super.key,
      required this.Buttontext,
      required this.myColor,
      required this.textcolor,
      required this.clicked,
      this.buttonsize});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        splashColor: Apptheme.mygrey,

        onTap: clicked,
        // onLongPress: clicked,
        borderRadius: BorderRadius.circular(100),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Ink(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: myColor,
              ),
              child: Center(
                child: Buttontext == 'x'
                    ? const Icon(
                        Iconsax.tag_cross_copy,
                        size: 32,
                      )
                    : Text(
                        Buttontext,
                        style: TextStyle(
                            color: textcolor,
                            fontSize: buttonsize ?? 25,
                            fontWeight: FontWeight.w600),
                      ),
              ),
            )),
      ),
    );
  }
}

class Navbutton extends StatelessWidget {
  const Navbutton(
      {super.key,
      required this.tapped,
      required this.index,
      required this.selectedindex,
      required this.icon});
  final VoidCallback tapped;
  final int index;
  final int selectedindex;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        splashColor: Apptheme.mygrey,

        onTap: tapped,
        // onLongPress: clicked,
        borderRadius: BorderRadius.circular(100),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                    selectedindex != index ? Apptheme.mygrey : Apptheme.primary,
              ),
              child: Center(
                  child: Icon(
                icon,
                size: 24,
                color:
                    selectedindex == index ? Colors.white : Apptheme.lightgrey,
              )),
            )),
      ),
    );
  }
}
