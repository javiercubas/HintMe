import 'package:flutter/material.dart';
import 'package:HintMe/sign_up.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45.h,
                          width: 100.w,
                          child: const Center(
                            child: Text(
                              "HintMe",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 40,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          // Login
                          height: 51.h,
                          width: 100.w,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                    width: 80.w,
                                    child: Text(
                                      'Holiiiiiii',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.sp, color: Colors.white),
                                    )),
                                Gap(3.h),
                                TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(80.w, 8.h)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ))),
                                    onPressed: () {
                                      signInWithGoogle();
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 22.sp,
                                            width: 22.sp,
                                            image: const NetworkImage(
                                                'https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png'),
                                          ),
                                          Gap(2.w),
                                          Text(
                                            "Iniciar sesión con Google"
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                color: Colors.black),
                                          )
                                        ])),
                                Gap(3.h),
                                TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(80.w, 8.h)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ))),
                                    onPressed: () {},
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 22.sp,
                                            width: 22.sp,
                                            image: const NetworkImage(
                                                'https://png.pngtree.com/png-vector/20221018/ourmid/pngtree-facebook-social-media-icon-png-image_6315968.png'),
                                          ),
                                          Gap(2.w),
                                          Text(
                                            "Iniciar sesión con Facebook"
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                color: Colors.black),
                                          )
                                        ])),
                                Gap(3.h),
                                TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(80.w, 8.h)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()),
                                      );
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 22.sp,
                                            width: 22.sp,
                                            image: const NetworkImage(
                                                'https://img2.freepng.es/20180413/cvq/kisspng-computer-icons-telephone-call-symbol-phone-vector-5ad050944a5c06.4562976915236015563046.jpg'),
                                          ),
                                          Gap(2.w),
                                          Text(
                                            "Iniciar sesión con Correo"
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                color: Colors.black),
                                          )
                                        ])),
                                Gap(1.h),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "¿No consigues iniciar sesión?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.sp,
                                          color: Colors.white),
                                    )),
                              ]),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
