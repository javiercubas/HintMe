import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/Login/login.dart';
import 'package:HintMe/screens/SignUp/create_user.dart';
import 'package:HintMe/screens/SignUp/avatar/upload_avatar.dart';
import 'package:HintMe/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:HintMe/Utils.dart' as Util;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final prefs = await SharedPreferences.getInstance();
  final showOnBoarding = prefs.getBool('showOnBoarding') ?? true;
  final id = prefs.getInt('currentUser');
  if (id != null) {
    final user = await Conexion.consultarUsuario(id);
    runApp(MyApp(showOnBoarding: showOnBoarding, usuario: user));
  } else {
    runApp(MyApp(showOnBoarding: showOnBoarding));
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showOnBoarding, this.usuario});
  final bool showOnBoarding;
  final Usuario? usuario;

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
            body: usuario != null
                ? HomePage(usuario: usuario!)
                : showOnBoarding
                    ? const OnBoarding()
                    : const LoginPage(),
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
