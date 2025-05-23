import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Page1 extends StatefulWidget {
  const Page1(
      {super.key,
      required this.svgasset,
      required this.title,
      required this.description});
  final String svgasset;
  final String title;
  final String description;

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
    return Padding(
      padding: const EdgeInsets.only(top: 150.0, left: 32, right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //svg image box of size 312
          SvgPicture.asset(
            widget.svgasset,
            width: svgsize,
            height: svgsize,
          ),
          const SizedBox(
            height: 50,
          ),

          // page title
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 40,
                fontFamily: "Fractul",
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.description,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: "Gilroy",
                color: Color.fromARGB(136, 0, 0, 0)),
          ),

          // page text
        ],
      ),
    );
  }
}
