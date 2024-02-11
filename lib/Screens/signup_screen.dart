import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthub/SCREENS/login_sceen.dart';
import 'package:icthub/Screens/home_screen.dart';
import 'package:icthub/Widgets/myButton.dart';
import 'package:icthub/Widgets/myForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // void initState() {
  //   super.initState();
  //   var db = FirebaseFirestore.instance;
  //   db.collection("users").add({
  //     "name": userNameController.text,
  //     "email": emailController.text,
  //     "phone": phoneNoController.text,
  //   });
  //
  // }
  //vars
  String e = '';
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyForm(
                controller: userNameController,
                label: 'Name',
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Name';
                  }
                  return null;
                },
              ),
              MyForm(
                controller: emailController,
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              MyForm(
                controller: phoneNoController,
                label: 'Phone Number',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Phone Number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  obscureText: passwordVisible,
                  controller: passwordController,
                  keyboardType: TextInputType.text, // textInputType
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFDADADA),
                        width: 1,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xff014f9f),
                        width: 1,
                      ),
                    ),
                    hintText: 'Pa**word',
                    hintStyle: const TextStyle(
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  obscureText: confirmPasswordVisible,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text, // textInputType
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFDADADA),
                        width: 1,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xff014f9f),
                        width: 1,
                      ),
                    ),
                    hintText: 'Confirm your Password',
                    hintStyle: const TextStyle(
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 70, top: 50)),
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: const Text("Sign in",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        )),
                  )
                ],
              ),
              MyButton(
                onPressed: () async {
                  try {
                    // await FirebaseFirestore.instance.collection("users").add({
                    //   "name": userNameController.text,
                    //   "email": emailController.text,
                    //   "phone": phoneNoController.text,
                    // });

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    )
                        .then(
                          (value) async {
                        if (value.user != null) {
                          await addUserDataToFireStoreDataBase(
                            name: userNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            uid: value.user!.uid,
                            phoneNo: phoneNoController.text,
                          ).then((value) {
                            ;
                          });
                        }
                      },
                    );
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    this.e = e as String;
                    print(e);
                  }
                  if (e == '') {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeApp(),
                        ));
                  }
                },
                label: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> addUserDataToFireStoreDataBase({
  required String name,
  required String email,
  required String password,
  required String uid,
  required String phoneNo,
}) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set(
    {
      "name": name,
      "email": email,
      "uid": uid,
      "phoneNo": phoneNo,
    },
  );
}
