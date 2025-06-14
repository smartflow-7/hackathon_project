import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LittleTile extends StatelessWidget {
  const LittleTile({
    super.key,
    required this.name,
    required this.percent,
    required this.symbol,
  });

  final String symbol;
  final String name;
  final String percent;

  @override
  Widget build(BuildContext context) {
    // Parse percentage to determine if it's positive or negative
    double percentValue = double.tryParse(percent.replaceAll('%', '')) ?? 0.0;
    bool isPositive = percentValue >= 0;
    var themecolor = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 181,
        height: 56,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.45,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      symbol,
                      style: TextStyle(
                        color: themecolor.primaryContainer,
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF94959D),
                        fontSize: 10,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    isPositive ? Iconsax.arrow_up_1 : Iconsax.arrow_down_1,
                    size: 16,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    percent.endsWith('%') ? percent : '$percent%',
                    style: TextStyle(
                      color: isPositive ? const Color(0xFF018C49) : Colors.red,
                      fontSize: 12,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
