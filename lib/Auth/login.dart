// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
import 'package:hackathon_project/Auth/forgottenpassword/forgot_password.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/logic/is_opening_app.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final VoidCallback change;
  const Login({super.key, required this.change});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool hidecpassword = true;
  bool ischecked = false;

  void togglecreate() {
    print(hidecpassword);
    setState(() {
      hidecpassword = !hidecpassword;
      print('toggle');
      print(hidecpassword);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    double width = size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    // final user = authProvider.user;
    final themeProvider = Provider.of<ThemeProvider>(context);
    var themecolor = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themecolor.surface,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.078, left: width * 0.058, right: 10, bottom: 40),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome ',
                      style: TextStyle(
                        color: themecolor.onPrimary,
                        fontSize: height * 0.046,
                        fontFamily: 'Fractul',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'back!',
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
                      'Create an account to start your trading journey, with the best tools we have to offer',
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
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        onEditingComplete: () => TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailcontroller,
                        style: const TextStyle(
                            color: Color(0xFF94959D), fontSize: 15),
                        decoration: const InputDecoration(
                            // labelText: 'email',
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
                        controller: _passwordcontroller,
                        keyboardType: TextInputType.text,
                        autofillHints: const [AutofillHints.password],
                        obscureText: hidecpassword,
                        style: const TextStyle(
                            color: Color(0xFF94959D), fontSize: 15),
                        decoration: InputDecoration(
                            // labelText: 'Password',
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
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: '  Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF94959D),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.023,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: ischecked,
                              activeColor: Apptheme.primary,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  ischecked = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                  color: Color(0xFF94959D),
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ForgotPassword(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Apptheme.primary,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    //const Spacer(),
                    //   const SizedBox.expand(),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        authProvider.signIn(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text);
                        if (authProvider.token != null &&
                            authProvider.token!.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Apptheme.primary,
                              content: Text(
                                'Signed in sucessfully',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Gilroy'),
                              ),
                            ),
                          );
                        }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => const Home(),
                        //   ),
                        // );
                        // FirstTimeUserManager.resetFirstTime();
                        // themeProvider.toggleTheme();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(26.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          color: Apptheme.primary,
                        ),
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: widget.change,
                          child: const Text(
                            'signup',
                            style: TextStyle(
                                color: Apptheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
