import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/components/separator.dart';
import 'package:HintMe/components/social_button.dart';
import 'package:HintMe/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PhoneVerifyingPage extends StatelessWidget {
  const PhoneVerifyingPage({super.key});

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
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          'Necesitamos tú número para verificar que las cuentas sean únicas. Te enviaremos un SMS al teléfono con un código de verificación que tendrás que escribir a continuación.',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp),
        ),
        Gap(4.h),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                  width: 20.w,
                  height: 6.h,
                  child: const Select()),
              InputForm(
                text: "Número de teléfono",
                textError: "Introduce un número de teléfono válido",
                width: 50.w,
              )
            ]),
        Gap(10.h),
        Center(
          child: ButtonAction(
            text: "Verificar número",
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

class Select extends StatefulWidget {
  const Select({super.key});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
