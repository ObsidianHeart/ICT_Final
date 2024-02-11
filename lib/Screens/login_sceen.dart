
import 'package:flutter/material.dart';
import 'package:icthub/Widgets/myButton.dart';
import 'package:icthub/Screens/signup_screen.dart';
import 'package:icthub/Widgets/myForm.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Vars
  bool passwordVisible = true;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
            ),
            MyForm(
              controller: emailController,
              label: 'email',
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                  hintText: 'Please Enter your Password',
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
                const Text("Don't have an Account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ));
                  },
                  child: const Text("Sign up",
                      style: TextStyle(
                        color: Colors.blueAccent,
                      )),
                )
              ],
            ),

            MyButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text , password: passwordController.text);
                  if (FirebaseAuth.instance.currentUser?.emailVerified ==
                      false) {
                    await FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ));
                  }
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                }

              },
              label: 'Login',
            ),
            // Container(
            //   margin: EdgeInsets.all(20),
            //   width: 300,
            //   color: Colors.blueAccent,
            //   child: TextButton(onPressed: () async {
            //     try {
            //       await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
            //       if (FirebaseAuth.instance.currentUser?.emailVerified == false) {
            //         await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            //         print("Done if cond!");
            //       }
            //       else{
            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav(),));
            //         print("Done nav!");
            //       }
            //     } on FirebaseAuthException catch (e) {
            //       print (e.message) ;
            //       print("Done error!");
            //     }
            //     print("Done!");
            //
            //
            //
            //   }, child: Text("Sign in" , style: TextStyle(fontSize: 18 , color: Colors.white),)),
            // ),
          ],
        ),
      ),
    );
  }
}
