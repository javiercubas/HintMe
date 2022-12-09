import 'package:HintMe/screens/Login/login.dart';
import 'package:HintMe/screens/SignUp/create_user.dart';
import 'package:HintMe/screens/SignUp/upload_avatar.dart';
import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HintMe/Utils.dart' as Util;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  final prefs = await SharedPreferences.getInstance();
  final showOnBoarding = prefs.getBool('showOnBoarding') ?? true;

  runApp(MyApp(showOnBoarding: showOnBoarding));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 1))
      .then((value) => FlutterNativeSplash.remove());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showOnBoarding});
  final bool showOnBoarding;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          scaffoldMessengerKey: Util.Utils.messengerKey,
          navigatorKey: navigatorKey,
          title: 'HintMe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Scaffold(
            body: showOnBoarding
                ? const OnBoarding()
                : StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong!"));
                      } else if (snapshot.hasData) {
                        return FutureBuilder<DocumentSnapshot>(
                            future: users
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              print(snapshot);
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data!.data() != null) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  if (data['avatar'] == null) {
                                    return const UploadAvatarPage();
                                  } else if (data['user'] == null) {
                                    return const CreateUserPage();
                                  } else {
                                    return const HomePage();
                                  }
                                }
                              }
                              return Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Color.fromARGB(255, 103, 58, 183),
                                        Color.fromARGB(255, 31, 3, 98)
                                      ])),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )));
                            });
                      } else {
                        return const LoginPage();
                      }
                    }),
          ));
    });
  }
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({
    Key? key,
  }) : super(key: key);
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = LiquidController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      LiquidSwipe(
          liquidController: controller,
          onPageChangeCallback: (index) {
            setState(() => isLastPage = index == 2);
          },
          pages: [
            Container(
              color: Colors.yellow,
              child: const Center(child: Text("Page 1")),
            ),
            Container(
              color: Colors.red,
              child: const Center(child: Text("Page 2")),
            ),
            Container(
              color: Colors.blue,
              child: const Center(child: Text("Page 3")),
            )
          ]),
      Positioned(
          bottom: 0,
          left: 16,
          right: 32,
          child: isLastPage
              ? Center(
                  child: TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showOnBoarding', false);
                      },
                      child: const Text("GET STARTED",
                          style: TextStyle(color: Colors.white))),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(page: 2);
                        },
                        child: const Text("SKIP",
                            style: TextStyle(color: Colors.white))),
                    AnimatedSmoothIndicator(
                      activeIndex: controller.currentPage,
                      count: 3,
                      effect: const WormEffect(
                          spacing: 16,
                          dotColor: Colors.white54,
                          activeDotColor: Colors.white),
                      onDotClicked: ((index) {
                        controller.animateToPage(page: index);
                      }),
                    ),
                    TextButton(
                        onPressed: () {
                          final page = controller.currentPage + 1;

                          controller.animateToPage(
                              page: page > 3 ? 0 : page, duration: 400);
                        },
                        child: const Text("NEXT",
                            style: TextStyle(color: Colors.white)))
                  ],
                ))
    ]));
  }
}
