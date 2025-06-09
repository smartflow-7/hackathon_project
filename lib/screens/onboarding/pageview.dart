import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/onboarding_stack_widgets.dart';
import 'package:hackathon_project/models/page_class.dart';

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
    var themecolor = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themecolor.surface,
      resizeToAvoidBottomInset: false,
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
                return onboardpages[index];
              }),
          Onboardingstack(currentIndex: _currentIndex, controller: _controller),
        ],
      ),
    );
  }
}
