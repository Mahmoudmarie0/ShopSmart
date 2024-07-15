import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.onPressed});
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        onPressed!();

        //controller.login();
      },
      label: const Text(
        'Sign in with Google',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12.0),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
