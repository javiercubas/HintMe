import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.action, required this.image});
  final String action;
  final String image;
  @override
  Widget build(BuildContext context) {
    return socialButton(context, action: action, image: image);
  }

  Container socialButton(BuildContext context,
      {required String action, required String image}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: IconButton(
            icon: ImageIcon(NetworkImage(image)),
            onPressed: () {
              signInWithGoogle();
            }));
  }

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
}
