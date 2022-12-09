import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class IndirectasContainer extends StatelessWidget {
  const IndirectasContainer({super.key, required this.lock});
  final bool lock;
  @override
  Widget build(BuildContext context) {
    return indirectasDiv(lock: lock);
  }

  Column indirectasDiv({required bool lock}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Indirectas de hoy',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16.sp)),
      Gap(3.h),
      lock ? indirectasError() : indirectasError()
    ]);
  }

  Container indirectasError() {
    return Container(
      width: 90.w,
      height: 18.h,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
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
