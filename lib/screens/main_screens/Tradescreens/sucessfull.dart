import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_project/wrapper.dart';

class Sucessfull extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const Sucessfull({super.key, required this.name, required this.symbol});
  final String name;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double svgsize = height / 3;
    return Scaffold(
      backgroundColor: themecolor.surface,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 76,
              ),
              SvgPicture.asset(
                'lib/assets/BLOCKCHAIN.svg', // Replace with your actual asset path
                //  isdarkmode == true ? mypages[0].svgasset : mypages[0].darksvgasset,
                width: svgsize,
                height: svgsize,
              ),
              const SizedBox(
                height: 54,
              ),
              Text(
                'Purchase Complete',
                style: TextStyle(
                    color: themecolor.onPrimary,
                    fontFamily: 'Fractul',
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Congratulations! You’ve successfully Purchased',
                style: TextStyle(
                    color: themecolor.onPrimary,
                    fontFamily: 'Gilroy',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: themecolor.primary,
                      ),
                    ),
                    TextSpan(
                      text: '($symbol)',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: themecolor.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Wrapper()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(26.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: themecolor.primaryContainer,
                  ),
                  child: Center(
                    child: Text(
                      'View my portfolio',
                      style: TextStyle(
                          color: themecolor.onPrimary,
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
