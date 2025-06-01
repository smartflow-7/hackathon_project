import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/api_service.dart';
import 'package:hackathon_project/components/button.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int selectedindex = 0;
    final authProvider = Provider.of<AuthProvider>(context);
    var themecolor = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themecolor.surface,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            const Column(),
            Navbarcustom(
                authProvider: authProvider, selectedindex: selectedindex)
          ],
        ),
      ),
    );
  }
}

class Navbarcustom extends StatefulWidget {
  Navbarcustom({
    super.key,
    required this.authProvider,
    required this.selectedindex,
  });

  final AuthProvider authProvider;
  int selectedindex;

  @override
  State<Navbarcustom> createState() => _NavbarcustomState();
}

class _NavbarcustomState extends State<Navbarcustom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Navbutton(
                  tapped: () {
                    widget.authProvider.signOut();
                    setState(() {
                      widget.selectedindex = 0;
                    });
                  },
                  index: 0,
                  selectedindex: widget.selectedindex,
                  icon: Iconsax.home_1_copy),
              Navbutton(
                  tapped: () {
                    setState(() {
                      widget.selectedindex = 1;
                    });
                  },
                  index: 1,
                  selectedindex: widget.selectedindex,
                  icon: Iconsax.wallet_3_copy),
              Navbutton(
                  tapped: () {
                    setState(() {
                      widget.selectedindex = 2;
                    });
                  },
                  index: 2,
                  selectedindex: widget.selectedindex,
                  icon: Iconsax.home_1_copy),
              Navbutton(
                  tapped: () {
                    setState(() {
                      widget.selectedindex = 3;
                    });
                  },
                  index: 3,
                  selectedindex: widget.selectedindex,
                  icon: Iconsax.home_1_copy),
            ],
          ),
        ),
      ),
    );
  }
}
