import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class IndirectasContainer extends StatelessWidget {
  const IndirectasContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return indirectasDiv();
  }

  Column indirectasDiv() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Indirectas de hoy',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16.sp)),
      Gap(4.h),
      indirectasError()
    ]);
  }

  Container indirectasError() {
    return Container(
      width: 90.w,
      height: 18.h,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Color.fromRGBO(49, 45, 45, 1),
      ),
      child: const Center(
          child: Text(
        'Para poder ver las indirectas de tus amigos es necesario que subas tu indirecta diaria.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      )),
    );
  }
}
