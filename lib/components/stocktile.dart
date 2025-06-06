import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Stocktile extends StatelessWidget {
  const Stocktile({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
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
                          'DNGTE',
                          style: TextStyle(
                            color: themecolor.onPrimary,
                            fontSize: 12,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      //    SizedBox(height: 4),
                      const Text(
                        'Dangote',
                        style: TextStyle(
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
                      const Text(
                        '\$324.56',
                        style: TextStyle(
                          color: Color(0xFF94959D),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
