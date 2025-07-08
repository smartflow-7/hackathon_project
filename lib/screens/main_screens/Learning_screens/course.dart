import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/edutile.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Course extends StatelessWidget {
  const Course({
    super.key,
    required this.title,
    required this.description,
    required this.inageurl,
  });
  final String title;
  final String description;
  final String inageurl;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: themecolor.onPrimary,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back_rounded,
                            size: 20, color: themecolor.onPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          color: themecolor.onPrimary,
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: themecolor.onPrimary,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Icon(Iconsax.bubble_copy,
                          size: 20, color: themecolor.onPrimary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: themecolor.onPrimary,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Icon(Iconsax.notification_bing_copy,
                          size: 20, color: themecolor.onPrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LargeEdutile(
                  description: description, title: title, inageurl: inageurl),
            ],
          ),
        ),
      ),
    );
  }
}
