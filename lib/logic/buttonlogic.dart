//import 'package:flutter/material.dart';

// this File contains all the logic of the app
//It also contains the string liist of buttons
String question = '';
String answer = '';
// ignore: non_constant_identifier_names
String ANS = '';
bool showequalsto = false;
bool clrscr = false;
String sub = '';
final List<String> buttons = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '',
  '0',
  'x'
];
// bool first(int x) {
//   if (x == 1 || x == 2 || x == 3) {
//     return true;
//   } else {
//     return false;
//   }
// }
String substr() {
  if (question.length >= 3) {
    sub = question.substring(question.length - 3);
    return sub;
  } else {
    return '';
  }
}

double buttonsizepickerr(String text) {
  if (text == '%' || text == '/' || text == 'X' || text == '-' || text == '+') {
    return 32;
  } else if (text == '=') {
    return 80;
  } else {
    return 25;
  }
}
