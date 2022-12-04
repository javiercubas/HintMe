import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
                      children: [const Logo(), forgotPassword(context)],
                    ),
                  )),
                ))));
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
          text: "Introduce tu correo electrónico",
          textError: "Introduce un correo electrónico válido",
          width: 80.w,
        ),
        Center(
          child: ButtonAction(
            text: "Enviar Correo",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: const HomePage(),
            width: 80.w,
          ),
        ),
      ]),
    );
  }
}
