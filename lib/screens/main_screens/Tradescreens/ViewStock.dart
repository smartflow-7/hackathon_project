import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themecolor.surface,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: themecolor.onPrimary,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Center(
              child: Icon(Iconsax.lamp_charge_copy,
                  size: 20, color: themecolor.onPrimary),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User',
                style: TextStyle(
                  color: themecolor.onPrimary,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Hello There',
                style: TextStyle(
                  color: Color(0xFF94959D),
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const Spacer(),
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: themecolor.onPrimary,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Center(
              child: Icon(Iconsax.lamp_charge_copy,
                  size: 20, color: themecolor.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
