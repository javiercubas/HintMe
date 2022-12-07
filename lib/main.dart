import 'package:HintMe/screens/Login/login.dart';
import 'package:HintMe/screens/SignUp/create_user.dart';
import 'package:HintMe/screens/SignUp/upload_avatar.dart';
import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HintMe/Utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          title: 'HintMe',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Scaffold(
            body: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
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
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              if (data['avatar'] == null) {
                                return const UploadAvatarPage();
                              } else if (data['user'] == null) {
                                return const CreateUserPage();
                              } else {
                                return const HomePage();
                              }
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        });
                  } else {
                    return const LoginPage();
                  }
                }),
          ));
    });
  }
}
