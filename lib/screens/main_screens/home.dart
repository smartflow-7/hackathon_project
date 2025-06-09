import 'package:flutter/material.dart';
//import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/Widgets/button.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/charts.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/homeview.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/leaderboardpage.dart';
import 'package:hackathon_project/screens/main_screens/homescreenpages/news.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
//import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedindex = 0;
  final PageController controller = PageController();

  List<Widget> homePages = [
    const Homeview(),
    const Leaderboardpage(),
    const News(),
    const Charts()
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    var themecolor = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themecolor.surface,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: homePages.length,
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                selectedindex = index; // Fixed this line
              });
            },
            itemBuilder: (context, index) {
              return homePages[index];
            },
          ),
          Navbarcustom(
            currentIndex: selectedindex,
            onIndexChanged: (index) {
              setState(() {
                selectedindex = index;
              });
              controller.jumpToPage(index);
            },
          )
        ],
      ),
    );
  }
}

class Navbarcustom extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const Navbarcustom({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double boxheight = height / 9;
    var themecolor = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: themecolor.surface,
          // borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(111, 187, 187, 187),
              blurRadius: 50,
              spreadRadius: 13,
              offset: Offset(0, -2),
            ),
          ],
        ),
        height: boxheight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Navbutton(
                tapped: () => onIndexChanged(0),
                index: 0,
                selectedindex: currentIndex,
                icon_selected: Iconsax.home_trend_up_copy,
                icon: Iconsax.home_trend_up,
              ),
              Navbutton(
                tapped: () => onIndexChanged(1),
                index: 1,
                selectedindex: currentIndex,
                icon_selected: Iconsax.cup_copy,
                icon: Iconsax.cup,
              ),
              Navbutton(
                tapped: () => onIndexChanged(2),
                index: 2,
                selectedindex: currentIndex,
                icon_selected: Iconsax.firstline_copy,
                icon: Iconsax.firstline,
              ),
              Navbutton(
                tapped: () => onIndexChanged(3),
                index: 3,
                selectedindex: currentIndex,
                icon_selected: Iconsax.presention_chart_copy,
                icon: Iconsax.presention_chart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
