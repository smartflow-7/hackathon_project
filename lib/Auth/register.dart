// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:hackathon_project/components/apptheme.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                    'Hello ',
                    style: TextStyle(
                      color: const Color(0xFF03050B),
                      fontSize: height * 0.046,
                      fontFamily: 'Fractul',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'there!',
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
                      color: Apptheme.mygrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Apptheme.primary,
                      controller: _emailcontroller,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
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
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Apptheme.mygrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Apptheme.primary,
                        controller: _firstnamecontroller,
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
                  ),
                  SizedBox(
                    height: height * 0.023,
                  ),
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
                      controller: _lastnamecontroller,
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
                              color: Apptheme.lightgrey,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.lock_1_copy,
                            color: Apptheme.lightgrey,
                          ),
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
                      const Text(
                        'I agree to the ',
                        style: TextStyle(
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
                      const Text(
                        'and the ',
                        style: TextStyle(
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
                    onTap: () {},
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
