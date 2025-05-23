import 'package:flutter/material.dart';
import 'package:hackathon_project/components/onboarding_stack_widgets.dart';
import 'package:hackathon_project/models/page_class.dart';
import 'package:hackathon_project/screens/onboarding/page_1.dart';

class Pageviews extends StatefulWidget {
  const Pageviews({super.key});

  @override
  State<Pageviews> createState() => _PageviewsState();
}

class _PageviewsState extends State<Pageviews> {
  final PageController _controller = PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
              itemCount: mypages.length,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Page1(
                    svgasset: mypages[_currentIndex].svgasset,
                    title: mypages[_currentIndex].title,
                    description: mypages[_currentIndex].description);
              }),
          Onboardingstack(currentIndex: _currentIndex, controller: _controller),
        ],
      ),
    );
  }
}
