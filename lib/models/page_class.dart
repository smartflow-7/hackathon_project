import 'package:flutter/material.dart';
import 'package:hackathon_project/screens/onboarding/page2.dart';
import 'package:hackathon_project/screens/onboarding/page3.dart';
import 'package:hackathon_project/screens/onboarding/page_1.dart';

class PageClass {
  final String svgasset;
  final String darksvgasset;
  final String title;
  final String description;
  PageClass(
      {required this.description,
      required this.svgasset,
      required this.title,
      required this.darksvgasset});
}

PageClass page1 = PageClass(
    description:
        'Zero risk, no scams! Master the NSE with ₦1M virtual cash and practice buying real Nigerian stocks.',
    svgasset: 'lib/assets/WALLET_light.svg',
    darksvgasset: 'lib/assets/WALLET_dark-min.svg',
    title: 'Welcome to StockUp');

PageClass page2 = PageClass(
    description:
        'Be one of millions of people who use mobile banking for daily transactions.',
    svgasset: 'lib/assets/second.svg',
    darksvgasset: 'lib/assets/second_dark-min.svg',
    title: 'Trade Like It’s Real (But It’s Not)');
PageClass page3 = PageClass(
    description:
        'Earn badges, crush challenges, and dodge scams with AI-powered tips—all while trading virtual cash risk-free!',
    svgasset: 'lib/assets/third.svg',
    darksvgasset: 'lib/assets/WALLET_dark-min.svg',
    title: 'Unlock Your Inner Stock Guru ');
List<PageClass> mypages = [
  page1,
  page2,
  page3,
];
List<Widget> onboardpages = [const Page1(), const Page2(), const Page3()];
