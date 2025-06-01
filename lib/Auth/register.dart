// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/api_service.dart';
import 'package:hackathon_project/components/apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggle1});
  final VoidCallback toggle1;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  bool hidecreate = true;
  bool hideconfirm = true;

  bool isChecked = false;
  void togglecreate() {
    print(hidecreate);
    setState(() {
      hidecreate = !hidecreate;
      print('toggle');
      print(hidecreate);
    });
  }

  void toggleconfirm() {
    print(hideconfirm);
    setState(() {
      hideconfirm = !hideconfirm;
      print('toggle');
      print(hideconfirm);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _agecontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String passwordisvalid(String a, String b) {
      if (a == b) {
        return a;
      } else {
        print('error');
        return '';
      }
    }
    // SIGNUP FUNCTION
//     Future signup() async {
//       bool passwordisequal() {
//         if (_passwordcontroller.text.trim() ==
//             _confirmpasswordcontroller.text.trim()) {
//           return true;
//         } else {
//           return false;
//         }
//       }
// // for account signup to be true, the password and the confirm password must be true
// // PASSWORD VALIDATOR

//       Future<void> adduserdetails(
//         String firstname,
//         String lastname,
//         String email,
//         int age,
//       ) async {
//         try {
//           String uid = FirebaseAuth.instance.currentUser!.uid;
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(uid)
//               .set({
//                 'firstname': firstname,
//                 'lastname': lastname,
//                 'email': email,
//                 'age': age,
//                 'uid': uid
//               })
//               .then((_) => print('User details added successfully'))
//               .catchError(
//                   (error) => print('Failed to add user details: $error'));
//         } catch (e) {
//           print('Error adding user details: $e');
//         }
//       }

//       if (passwordisequal()) {
//         try {
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//               email: _emailcontroller.text.trim(),
//               password: _passwordcontroller.text.trim());

//           adduserdetails(
//             _firstnamecontroller.text.trim(),
//             _lastnamecontroller.text.trim(),
//             _emailcontroller.text.trim(),
//             int.parse(_agecontroller.text.trim()),
//           );
//           // ADDING THE FRIENDS SUBCOLLECTION TO USERS
//           database.addsubcollection(FirebaseAuth.instance.currentUser!.uid);
//         } catch (e) {
//           print(e.toString());
//         }
//       } else {
//         const AlertDialog();
//         print('passwords dont match');
//       }
//     }

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    print(height);
    print(width);
    final authProvider = Provider.of<AuthProvider>(context);
    var themecolor = Theme.of(context).colorScheme;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    'Hello ',
                    style: TextStyle(
                      color: themecolor.onPrimary,
                      fontSize: height * 0.046,
                      fontFamily: 'Fractul',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'there!',
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
                  Text(
                    'Create an account to start your trading journey, with the best tools we have to offer',
                    style: TextStyle(
                      color: themecolor.onPrimaryContainer,
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
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Iconsax.sms_copy,
                            color: themecolor.onPrimaryContainer,
                          ),
                          hintText: 'Enter your mail',
                          hintStyle: TextStyle(
                            color: themecolor.onPrimaryContainer,
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
                      controller: _firstnamecontroller,
                      obscureText: hideconfirm,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          // prefixIcon: icon,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Iconsax.profile_circle_copy,
                            color: themecolor.onPrimaryContainer,
                          ),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(
                            color: themecolor.onPrimaryContainer,
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
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: themecolor.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Apptheme.primary,
                        controller: _passwordcontroller,
                        obscureText: hidecreate,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            alignLabelWithHint: true,
                            suffixIcon: IconButton(
                              onPressed: togglecreate,
                              icon: Icon(
                                hidecreate == true
                                    ? Iconsax.eye_slash_copy
                                    : Iconsax.eye_copy,
                                color: themecolor.onPrimaryContainer,
                              ),
                            ),
                            prefixIcon: Icon(
                              Iconsax.lock_1_copy,
                              color: themecolor.onPrimaryContainer,
                            ),
                            hintText: 'Create password',
                            hintStyle: TextStyle(
                              color: themecolor.onPrimaryContainer,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.023,
                  ),
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
                      controller: _confirmpasswordcontroller,
                      obscureText: hideconfirm,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          // prefixIcon: icon,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: toggleconfirm,
                            icon: Icon(
                              hideconfirm == true
                                  ? Iconsax.eye_slash_copy
                                  : Iconsax.eye_copy,
                              color: themecolor.onPrimaryContainer,
                            ),
                          ),
                          prefixIcon: Icon(
                            Iconsax.lock_1_copy,
                            color: themecolor.onPrimaryContainer,
                          ),
                          hintText: 'Re-type your password',
                          hintStyle: TextStyle(
                            color: themecolor.onPrimaryContainer,
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
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: Apptheme.primary,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'I agree to the ',
                        style: TextStyle(
                            color: themecolor.onPrimaryContainer,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      const Text(
                        'Terms of Service ',
                        style: TextStyle(
                            color: Apptheme.primary,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        'and the ',
                        style: TextStyle(
                            color: themecolor.onPrimaryContainer,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 54.0),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: Apptheme.primary,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_passwordcontroller.text ==
                          _confirmpasswordcontroller.text) {
                        authProvider.signUp(
                            email: _emailcontroller.text,
                            password: passwordisvalid(_passwordcontroller.text,
                                _confirmpasswordcontroller.text),
                            name: _firstnamecontroller.text);
                      } else {
                        print('passwords are not the same');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(26.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44),
                        color: Apptheme.primary,
                      ),
                      child: const Center(
                        child: Text(
                          'Create your account',
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
                        'Already a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.toggle1,
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
