import 'package:flutter/material.dart';
import 'package:hackathon_project/components/onboard_buttons.dart';
import 'package:hackathon_project/logic/is_opening_app.dart';
import 'package:hackathon_project/wrapper.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'apptheme.dart';

class Onboardingstack extends StatelessWidget {
  const Onboardingstack({
    super.key,
    required int currentIndex,
    required PageController controller,
  })  : _currentIndex = currentIndex,
        _controller = controller;

  final int _currentIndex;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 50, left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Onboardbuttons(
                index: _currentIndex,
                buttonindex: 1,
              ),
              Onboardbuttons(
                index: _currentIndex,
                buttonindex: 2,
              ),
              Onboardbuttons(
                index: _currentIndex,
                buttonindex: 3,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (_currentIndex < 2) {
                _controller.animateToPage(
                  _currentIndex + 1, // index
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else if (_currentIndex == 2) {
                FirstTimeUserManager.setNotFirstTime();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Wrapper(),
                  ),
                );
              }

              // print('tapped');
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: _currentIndex == 2 ? 150 : 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: _currentIndex == 2
                    ? BorderRadius.circular(44)
                    : BorderRadius.circular(100),
                color: Apptheme.primary,
              ),
              child: Center(
                child: _currentIndex == 2
                    ? const Text(
                        'Jump right in',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    : const Icon(
                        Iconsax.arrow_right_4,
                        color: Colors.white,
                        size: 27,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
