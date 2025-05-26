import 'package:flutter/material.dart';
import 'package:hackathon_project/components/Apptheme.dart';
import 'package:hackathon_project/components/button.dart';
import 'package:hackathon_project/components/numberpadscreen.dart';
import 'package:hackathon_project/logic/buttonlogic.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double width = size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.078, left: width * 0.058, right: 10, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter the',
                      style: TextStyle(
                        color: const Color(0xFF03050B),
                        fontSize: height * 0.046,
                        fontFamily: 'Fractul',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'code',
                      style: TextStyle(
                        color: Apptheme.primary,
                        fontSize: height * 0.046,
                        fontFamily: 'Fractul',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.016,
                    ),
                    const Text(
                      'We’ve sent the code to your email address. Enter it below to start the reset process',
                      style: TextStyle(
                        color: Color(0xFF94959D),
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: height * 0.046),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Codescreen(
                          num: question.isNotEmpty ? question[0] : '',
                        ),
                        Codescreen(
                          num: question.length >= 2 ? question[1] : '',
                        ),
                        Codescreen(
                          num: question.length >= 3 ? question[2] : '',
                        ),
                        Codescreen(
                          num: question.length == 4 ? question[3] : '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: SizedBox(
                    // height: 80,
                    child: GridView.builder(
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Mybutton(
                                clicked: () {
                                  switch (buttons[index]) {
                                    case '':
                                      // code to execute
                                      break;
                                    case 'x':
                                      // code to execute
                                      if (question.isNotEmpty) {
                                        if (substr() == 'Ans') {
                                          setState(() {
                                            question = question.substring(
                                                0, question.length - 3);

                                            //print(question);
                                          });
                                        } else {
                                          setState(() {
                                            question = question.substring(
                                                0, question.length - 1);

                                            //print(question);
                                          });
                                        }
                                      }
                                      break;
                                    default:
                                      setState(() {
                                        question = question + buttons[index];
                                        //print(question);
                                      });

                                    // code to execute if no cases match
                                  }
                                },
                                buttonsize: buttonsizepickerr(buttons[index]),
                                Buttontext: buttons[index],
                                myColor: Colors.white,
                                textcolor: Colors.black),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
