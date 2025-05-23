import 'package:flutter/material.dart';
import 'package:hackathon_project/components/apptheme.dart';
import 'package:hackathon_project/logic/is_opening_app.dart';

class Login extends StatefulWidget {
  final VoidCallback change;
  const Login({super.key, required this.change});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

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

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: height / 4),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'login page',
                    style: loginstyle,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Apptheme.primary),
                    child: TextField(
                      cursorColor: Colors.greenAccent,
                      controller: _emailcontroller,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintText: '  email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Apptheme.primary),
                    child: TextField(
                      cursorColor: Colors.greenAccent,
                      controller: _passwordcontroller,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintText: '  Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.075,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                      onTap: () {
                        FirstTimeUserManager.resetFirstTime();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Apptheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Apptheme.primary,
                              fontSize: height / 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.075,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont hsve an account?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 25,
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
            ),
          ),
        ));
  }
}
