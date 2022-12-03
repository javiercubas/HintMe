import 'package:flutter/material.dart';
import 'package:HintMe/home.dart';

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
            final auth = action;
            if (auth != "") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
        ));
  }
}
