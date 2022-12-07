import 'package:HintMe/Utils.dart';
import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/components/separator.dart';
import 'package:HintMe/components/social_button.dart';
import 'package:HintMe/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:HintMe/screens/SignUp/sign_up.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';
import 'package:HintMe/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
                      children: [const Logo(), Login(context)],
                    ),
                  )),
                ))));
  }

  SizedBox Login(BuildContext context) {
    return SizedBox(
      // Login
      width: 100.w,
      child: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          InputForm(
              controller: emailController,
              password: false,
              text: "Introduce tu correo electrónico",
              width: 80.w,
              validator: ((email) => email != null && email.isEmail
                  ? null
                  : "Introduce un correo electrónico válido")),
          Gap(3.h),
          InputForm(
              controller: passwordController,
              password: true,
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonAction(
              text: "Registrarse",
              color: Colors.black,
              backgroundColor: Colors.white,
              action: const SignUpPage(),
              width: 35.w,
              fontStyle: FontStyle.normal,
            ),
            Gap(5.w),
            Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 20)
                  ],
                ),
                child: TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(35.w, 7.h)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    onPressed: () {
                      signIn();
                    },
                    child: Text(
                      "Iniciar sesión".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontStyle: FontStyle.normal),
                    ))),
          ]),
          Gap(1.h),
          forgotPassword(context),
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
      ),
    );
  }

  TextButton forgotPassword(context) {
    return TextButton(
        onPressed: () {
          Get.to(() => const ForgotPassword());
        },
        child: Text(
          "¿Has olvidado tu contraseña?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
              color: Colors.white),
        ));
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          "El correo y/o la contraseña introducidos son incorrectos. Intenta introducirlos de nuevo.");
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
