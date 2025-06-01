import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:hackathon_project/models/page_class.dart';
import 'package:provider/provider.dart';

class Page3 extends StatefulWidget {
  const Page3({
    super.key,
  });

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double svgsize = height / 3;
    // double rad = 40;
    final themeProvider = Provider.of<ThemeProvider>(context);
    var themecolor = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 150.0, left: 32, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //svg image box of size 312
          SvgPicture.asset(
            themeProvider.isDarkMode
                ? mypages[2].darksvgasset
                : mypages[2].svgasset,
            width: svgsize,
            height: svgsize,
          ),
          const SizedBox(
            height: 50,
          ),

          // page title
          Text(
            mypages[2].title,
            style: const TextStyle(
                fontSize: 35,
                fontFamily: "Fractul",
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(mypages[2].description,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Gilroy",
                color: themecolor.onPrimaryContainer,
              )),

          // page text
        ],
      ),
    );
  }
}
