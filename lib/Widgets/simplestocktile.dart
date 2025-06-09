import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Simplestocktile extends StatelessWidget {
  const Simplestocktile({super.key});

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
          child: Row(
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
                  const Text(
                    'Dangote',
                    style: TextStyle(
                      color: Color(0xFF94959D),
                      fontSize: 10,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  //  Spacer(),
                  SizedBox(
                    width: 41,
                    child: Text(
                      'DNGO',
                      style: TextStyle(
                        color: themecolor.onPrimary,
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '644.56',
                    style: TextStyle(
                      color: Color(0xFF018C49),
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //    SizedBox(height: 4),
                  // Spacer(),
                  Row(
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
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '\$3,765.22',
                    style: TextStyle(
                      color: themecolor.onPrimary,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //    SizedBox(height: 4),
                  // Spacer(),
                  const SizedBox(
                    width: 66,
                    child: Text(
                      '24 shares',
                      style: TextStyle(
                        color: Color(0xFF94959D),
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
