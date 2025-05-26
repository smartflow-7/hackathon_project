// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hackathon_project/components/apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({super.key});

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool hidecpassword = true;
  bool confirm = false;
  void togglecreate() {
    print(hidecpassword);
    setState(() {
      hidecpassword = !hidecpassword;
      print('toggle');
      print(hidecpassword);
    });
  }

  void toggleconfirm() {
    print(hidecpassword);
    setState(() {
      confirm = !confirm;
      print('toggle');
      print(confirm);
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your new ',
                    style: TextStyle(
                      color: const Color(0xFF03050B),
                      fontSize: height * 0.046,
                      fontFamily: 'Fractul',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'password',
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
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Apptheme.mygrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Apptheme.primary,
                      controller: _emailcontroller,
                      obscureText: hidecpassword,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: togglecreate,
                            icon: Icon(
                              hidecpassword == true
                                  ? Iconsax.eye_slash_copy
                                  : Iconsax.eye_copy,
                              color: Apptheme.lightgrey,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.lock_1_copy,
                            color: Apptheme.lightgrey,
                          ),
                          hintText: 'Create password',
                          hintStyle: const TextStyle(
                            color: Apptheme.lightgrey,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          )),
                    ),
                  ),
                  SizedBox(height: height * 0.023),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Apptheme.mygrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Apptheme.primary,
                      controller: _passwordcontroller,
                      obscureText: confirm,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: toggleconfirm,
                            icon: Icon(
                              confirm == true
                                  ? Iconsax.eye_slash_copy
                                  : Iconsax.eye_copy,
                              color: Apptheme.lightgrey,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.lock_1_copy,
                            color: Apptheme.lightgrey,
                          ),
                          contentPadding: const EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintText: 'Re-type your password',
                          hintStyle: const TextStyle(
                            color: Apptheme.lightgrey,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.023,
                  ),

                  //const Spacer(),
                  //   const SizedBox.expand(),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // FirstTimeUserManager.resetFirstTime();
                },
                child: Container(
                  padding: const EdgeInsets.all(26.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: Apptheme.primary,
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
