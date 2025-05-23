import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/login.dart';
import 'package:hackathon_project/Auth/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showloginpage = false;

  void togglepage() {
    print(showloginpage);
    setState(() {
      showloginpage = !showloginpage;
      print('toggle');
      print(showloginpage);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Register(toggle1: togglepage);
    } else {
      return Login(
        change: togglepage,
      );
    }
  }
}
