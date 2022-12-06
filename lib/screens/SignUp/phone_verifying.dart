import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/screens/SignUp/upload_avatar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class PhoneVerifyingPage extends StatefulWidget {
  const PhoneVerifyingPage({super.key});

  @override
  _PhoneVerifyingPageState createState() => _PhoneVerifyingPageState();
}

class _PhoneVerifyingPageState extends State<PhoneVerifyingPage> {
  final phoneController = TextEditingController();
  final countryPicker = const FlCountryCodePicker();

  @override
  void dispose() {
    phoneController.dispose();

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
      width: 80.w,
      height: 60.h,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          'Necesitamos tú número para verificar que las cuentas sean únicas. Te enviaremos un SMS al teléfono con un código de verificación que tendrás que escribir a continuación.',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  final code = await countryPicker.showPicker(context: context);
                  if (code != null) print(code);
                },
                child: Container(
                  height: 7.25.h,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(103, 58, 183, 1),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(31, 3, 98, 1),
                          offset: Offset(4, 4),
                          blurRadius: 20)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: 25.w,
                  padding: const EdgeInsets.all(6),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        Text(
                          "Prefijo",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        )
                      ])),
                ),
              ),
              InputForm(
                  controller: phoneController,
                  text: "Número de teléfono",
                  width: 50.w,
                  validator: ((tel) => tel != null && tel.isPhoneNumber
                      ? null
                      : "Introduce un número de teléfono válido")),
            ]),
        Center(
          child: ButtonAction(
            text: "Verificar número",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: const UploadAvatarPage(),
            width: 80.w,
            fontStyle: FontStyle.normal,
          ),
        ),
      ]),
    );
  }
}
