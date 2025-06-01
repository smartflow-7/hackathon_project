import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/forgottenpassword/OTP_verification.dart';
import 'package:hackathon_project/components/Apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double width = size.width;
    var themecolor = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themecolor.surface,
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
                    'Forgot your',
                    style: TextStyle(
                      color: themecolor.onPrimary,
                      fontSize: height * 0.046,
                      fontFamily: 'Fractul',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'password?',
                    style: TextStyle(
                      color: themecolor.primary,
                      fontSize: height * 0.046,
                      fontFamily: 'Fractul',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  const Text(
                    'Enter your email address below so we can send the code ',
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
                      color: themecolor.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Apptheme.primary,
                      controller: _emailcontroller,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Iconsax.sms_copy,
                            color: Apptheme.lightgrey,
                          ),
                          hintText: 'Enter your mail',
                          hintStyle: TextStyle(
                            color: Apptheme.lightgrey,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          )),
                    ),
                  ),
                  SizedBox(height: height * 0.023),

                  SizedBox(
                    height: height * 0.023,
                  ),

                  //const Spacer(),
                  //   const SizedBox.expand(),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const OtpVerification(),
                        ),
                      );
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
            ],
          ),
        ));
  }
}
