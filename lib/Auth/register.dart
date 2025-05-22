// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:hackathon_project/components/Apptheme.dart';

// import '../components/apptheme.dart';

// class Register extends StatefulWidget {
//   const Register({super.key, required this.toggle1});
//   final VoidCallback toggle1;

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _emailcontroller = TextEditingController();
//   final _passwordcontroller = TextEditingController();
//   final _confirmpasswordcontroller = TextEditingController();
//   final _firstnamecontroller = TextEditingController();
//   final _lastnamecontroller = TextEditingController();
//   final _agecontroller = TextEditingController();
  

//   @override
//   void dispose() {
//     super.dispose();
//     _emailcontroller.dispose();
//     _passwordcontroller.dispose();
//     _agecontroller.dispose();
//     _confirmpasswordcontroller.dispose();
//     _firstnamecontroller.dispose();
//     _lastnamecontroller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SIGNUP FUNCTION
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

//     Size size = MediaQuery.of(context).size;
//     //double width = size.width;
//     double height = size.height;

//     return Scaffold(
//         backgroundColor: Apptheme.primary,
//         body: Padding(
//           padding: EdgeInsets.only(top: height / 6),
//           child: Container(
//             height: double.infinity,
//             decoration: BoxDecoration(
//                 color: Apptheme.primary,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20))),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Register',
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                         ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _firstnamecontroller,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  Firstname',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                          ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _lastnamecontroller,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  lastname',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                         ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _emailcontroller,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  email',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                          ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _passwordcontroller,
//                         obscureText: true,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  Password',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                          ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _confirmpasswordcontroller,
//                         obscureText: true,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  Confirm password',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(
//                           color: AppColor.background,
//                          ),
//                       child: TextField(
//                         cursorColor: Colors.greenAccent,
//                         controller: _agecontroller,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 15),
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             border: InputBorder.none,
//                             hintText: '  Age',
//                             hintStyle: TextStyle(color: Colors.grey)),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 100),
//                       child: GestureDetector(
//                         onTap: signup,
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: const Color.fromARGB(255, 50, 47, 80),
//                              ),
//                           child: Center(
//                             child: Text(
//                               'SIGNUP',
//                               style: TextStyle(
//                                 color: AppColor.background,
//                                 fontSize: height / 35,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Already a member?',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: widget.toggle1,
//                           child: const Text(
//                             'LOGIN',
//                             style: TextStyle(
//                                 color: Colors.blueAccent,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
