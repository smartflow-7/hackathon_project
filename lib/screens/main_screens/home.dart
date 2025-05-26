import 'package:flutter/material.dart';
import 'package:hackathon_project/components/button.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedindex = 0;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Navbutton(
                          tapped: () {},
                          index: 0,
                          selectedindex: selectedindex,
                          icon: Iconsax.home_1_copy),
                      Navbutton(
                          tapped: () {},
                          index: 1,
                          selectedindex: selectedindex,
                          icon: Iconsax.wallet_3_copy),
                      Navbutton(
                          tapped: () {},
                          index: 2,
                          selectedindex: selectedindex,
                          icon: Iconsax.home_1_copy),
                      Navbutton(
                          tapped: () {},
                          index: 3,
                          selectedindex: selectedindex,
                          icon: Iconsax.home_1_copy),
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
