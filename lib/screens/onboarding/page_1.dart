import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hackathon_project/models/page_class.dart';

class Page1 extends StatefulWidget {
  const Page1({
    super.key,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double svgsize = height / 3;
    // double rad = 40;
    var themecolor = Theme.of(context).colorScheme;

    bool isdarkmode = true;
    //final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 150.0, left: 32, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //svg image box of size 312
          SvgPicture.asset(
            isdarkmode == true ? mypages[0].svgasset : mypages[0].darksvgasset,
            width: svgsize,
            height: svgsize,
          ),
          const SizedBox(
            height: 50,
          ),

          // page title
          Text(
            mypages[0].title,
            style: const TextStyle(
                fontSize: 35,
                fontFamily: "Fractul",
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            mypages[0].description,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Gilroy",
              color: themecolor.onPrimaryContainer,
            ),
          )
          // page text
        ],
      ),
    );
  }
}
