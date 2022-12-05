import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/components/separator.dart';
import 'package:HintMe/components/social_button.dart';
import 'package:HintMe/screens/SignUp/phone_verifying.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:validators/validators.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 103, 58, 183),
                      Color.fromARGB(255, 31, 3, 98)
                    ])),
                child: SafeArea(
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [const Logo(), signUp(context)],
                    ),
                  )),
                ))));
  }

  SizedBox signUp(BuildContext context) {
    return SizedBox(
      // Login
      width: 100.w,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        InputForm(
            controller: nameController,
            text: "Introduce tu nombre completo",
            width: 80.w,
            validator: ((name) => name != null && name.isAlphabetOnly
                ? null
                : "Introduce un nombre válido")),
        Gap(3.h),
        InputForm(
            controller: emailController,
            text: "Introduce tu correo electrónico",
            width: 80.w,
            validator: ((email) => email != null && email.isEmail
                ? null
                : "Introduce un correo electrónico válido")),
        Gap(3.h),
        InputForm(
            controller: passwordController,
            text: "Introduce tu contraseña",
            width: 80.w,
            validator: ((value) => value != null &&
                    value.length >= 8 &&
                    value.length <= 18 &&
                    !isNumeric(value) &&
                    !isLowercase(value) &&
                    !isUppercase(value) &&
                    !isAlpha(value)
                ? null
                : "Introduce una contraseña válida")),
        Gap(3.h),
        Center(
          child: ButtonAction(
            text: "Siguiente",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: const PhoneVerifyingPage(),
            width: 80.w,
            fontStyle: FontStyle.normal,
          ),
        ),
        Gap(4.h),
        const Separator(),
        Gap(4.h),
        SizedBox(
          width: 80.w,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SocialButton(
                    image:
                        "https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png",
                    action: 'signInWithGoogle()'),
                SocialButton(
                    image:
                        "https://assets.stickpng.com/images/580b57fcd9996e24bc43c516.png",
                    action: 'signInWithGoogle()'),
                SocialButton(
                    image:
                        "https://cdn-icons-png.flaticon.com/512/20/20673.png",
                    action: 'signInWithGoogle()'),
              ]),
        )
      ]),
    );
  }
}
