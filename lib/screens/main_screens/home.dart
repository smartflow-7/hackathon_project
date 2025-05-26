import 'package:flutter/material.dart';
import 'package:hackathon_project/components/button.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            const Column(),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Navbutton(
                          tapped: () {},
                          index: 1,
                          selectedindex: 1,
                          icon: Iconsax.home_1_copy)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
