import 'package:HintMe/Utils.dart';
import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/components/separator.dart';
import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/forgot_password.dart';
import 'package:HintMe/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:HintMe/screens/SignUp/sign_up.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
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
              validator: null),
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
        builder: (context) => Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 103, 58, 183),
                  Color.fromARGB(255, 31, 3, 98)
                ])),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )));
    Usuario? usuario =
        await Conexion.login(emailController.text, passwordController.text);

    if (usuario != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('currentUser', usuario.id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(usuario: usuario)),
      );
    } else {
      Navigator.pop(context);
    }
  }
}
