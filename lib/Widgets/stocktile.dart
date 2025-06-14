import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_project/Widgets/simplestocktile.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Stocktile extends StatelessWidget {
  const Stocktile(
      {super.key,
      required this.name,
      required this.price,
      required this.sector,
      required this.symbol});
  final String symbol;
  final String name;
  final double price;
  final String sector;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        width: 220,
        height: 158,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // first row
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.africanfinancials.com/ng-dangce-logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      SizedBox(
                        width: 41,
                        child: Text(
                          symbol,
                          style: TextStyle(
                            color: themecolor.onPrimary,
                            fontSize: 12,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      //    SizedBox(height: 4),
                      Text(
                        limitText(name),
                        style: const TextStyle(
                          color: Color(0xFF94959D),
                          fontSize: 10,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Iconsax.arrow_up_1, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        '4.32%',
                        style: TextStyle(
                          color: Color(0xFF018C49),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //spacer
              const Spacer(),
              //second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shares',
                        style: TextStyle(
                          color: Color(0xFF94959D),
                          fontSize: 10,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '48.67',
                        style: TextStyle(
                          color: themecolor.onPrimary,
                          fontSize: 20,
                          fontFamily: 'Okta Neue',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          color: Color(0xFF94959D),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // const Spacer(),
                    ],
                  ),
                  ////////////////////////////////////////////////
                  const Spacer(),
                  SvgPicture.asset(
                    'lib/assets/Vector 1.svg',
                    colorFilter: themeProvider.isDarkMode
                        ? const ColorFilter.mode(
                            Colors.white12, BlendMode.srcIn)
                        : null,
                    width: 78,
                    height: 47,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
