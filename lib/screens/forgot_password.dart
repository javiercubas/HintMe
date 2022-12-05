import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/button_function.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:HintMe/Utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

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
                      child: Form(
                    key: formKey,
                    child: Column(
                      children: [const Logo(), forgotPassword(context)],
                    ),
                  )),
                )))));
  }

  SizedBox forgotPassword(BuildContext context) {
    return SizedBox(
      // Login
      width: 80.w,
      height: 60.h,

      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          'Indique a continuación su correo electrónico para recuperar su contrseña.',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp),
        ),
        InputForm(
            controller: emailController,
            text: "Introduce tu correo electrónico",
            width: 80.w,
            validator: ((email) =>
                email != null && EmailValidator.validate(email)
                    ? null
                    : "Introduce un correo electrónico válido")),
        Center(
          child: ButtonFunction(
            text: "Enviar Correo",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: verifyEmail(),
            width: 80.w,
            fontStyle: FontStyle.normal,
          ),
        ),
      ]),
    );
  }

  Future verifyEmail() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Email enviado con éxito.');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
