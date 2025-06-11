import 'package:flutter/material.dart';

class Ranktile extends StatelessWidget {
  const Ranktile(
      {super.key,
      required this.balance,
      required this.id,
      required this.index,
      required this.name});

  final String id;
  final String name;
  final double balance;
  final int index;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: themecolor.primaryContainer,
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        //   spacing: 82,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: themecolor.onPrimary,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                //  spacing: 16,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFDC39A), Color(0xFFC6CDF0)],
                          stops: [0.28, 0.87],
                          transform: GradientRotation(-3.14),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: themecolor.onPrimary,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            // spacing: 8,
            children: [
              const Text(
                'Value',
                style: TextStyle(
                  color: Color(0xFF4B61D1),
                  fontSize: 12,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formatBalance(balance),
                style: TextStyle(
                  color: themecolor.onPrimary,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatBalance(double balance) {
  if (balance < 1000) {
    return balance.toString(); // No suffix for values under 1,000
  }

  // Determine the appropriate suffix
  if (balance < 1000000) {
    return "${(balance / 1000).toStringAsFixed(1)}K"; // Thousands
  } else if (balance < 1000000000) {
    return "${(balance / 1000000).toStringAsFixed(1)}M"; // Millions
  } else {
    return "${(balance / 1000000000).toStringAsFixed(1)}B"; // Billions
  }
}
