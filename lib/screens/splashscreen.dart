import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_project/components/Apptheme.dart';
import 'package:hackathon_project/screens/onboarding/pageview.dart';
import 'dart:async';

import 'package:hackathon_project/wrapper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Pageviews(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/logo.svg',
              width: 45,
              height: 45,
            ),
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              'lib/assets/stockup.svg',
              width: 145,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
