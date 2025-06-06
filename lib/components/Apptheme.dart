import 'package:flutter/material.dart';

const double appVersion = 2.3;
const splashscreenstyle = TextStyle(
    color: Colors.white,
    fontFamily: "GowunBatang-Regular",
    fontSize: 50,
    fontWeight: FontWeight.w700);

const title =
    TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold);

const loginstyle = TextStyle(
    color: Colors.black,
    fontSize: 45,
    fontFamily: 'ace',
    fontWeight: FontWeight.w400);

const texty =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
const friendtexty =
    TextStyle(color: Colors.white, fontSize: 15.5, fontWeight: FontWeight.bold);
const textybig =
    TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
const textyblack = TextStyle(
    color: Color.fromARGB(216, 0, 0, 0),
    fontSize: 20,
    fontWeight: FontWeight.bold);
const textygreen = TextStyle(
    color: Color.fromARGB(188, 105, 240, 175),
    fontSize: 20,
    fontWeight: FontWeight.w700);

class Apptheme {
  static const Gradient mygrad = LinearGradient(
    begin: AlignmentDirectional(0, 1),
    end: AlignmentDirectional(1, 0),
    colors: [
      Color(0xFFFDC39A),
      Color(0xFFC6CDF0),
    ],
    stops: [0.28, 0.87],
    transform: GradientRotation(-3.14),
  );
  static const Gradient mesh = SweepGradient(
    colors: [
      Color(0xFFFDC39A),
      Color(0xFFC6CDF0),
    ],
    stops: [0.25, 0.75],
    center: Alignment(1.0, -1.0),
  );
  static const darkmygrey = Color(0xFF0B0C13);

  static const darklightgrey = Color(0xFF4D4E55);

  static const darkg = Color(0xFF0B0C13);

  static const tigerlight = Color.fromARGB(255, 255, 243, 235);
  static const tigerdark = Color(0xFFFC6A03);
  static const grey = Color.fromARGB(255, 239, 243, 251);
  static const primary = Color.fromARGB(255, 75, 97, 209);
  static const mygrey = Color(0xFFF6F7F7);
  static const lightgrey = Color.fromARGB(255, 172, 172, 172);

  static const primarycolor = Color.fromRGBO(28, 143, 106, 1);
  static const yellowcolor = Color.fromRGBO(255, 255, 0, 1);
  static const dark = Color.fromARGB(255, 15, 32, 32);
  static const green = Colors.greenAccent;
  //Size size = MediaQuery.of(context).size;
}

class Appicons {
//   static const logo = 'lib/Assets/barbell.png';
//   static const fire = 'lib/Assets/fire.png';
//   static const badge = 'lib/Assets/badge.png';
//   static const curve = 'lib/Assets/curve.png';
//   static const hourglass = 'lib/Assets/hour-glass.png';
//   static const group = 'lib/Assets/group.png';
//   static const competition = 'lib/Assets/competition.png';
//
}
