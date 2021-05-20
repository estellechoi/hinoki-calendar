import 'package:flutter/material.dart';
import '../../utils/auth_provider.dart';
import './../buttons/hinoki_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart' as colors;

class SignInWithAppleButton extends StatefulWidget {
  final ValueChanged<User?> onSuccess;
  final onError;
  final bool fullWidth;
  final String toggledText;

  SignInWithAppleButton(
      {required this.onSuccess,
      required this.onError,
      this.fullWidth = false,
      this.toggledText = 'in'});

  @override
  _SignInWithAppleButtonState createState() => _SignInWithAppleButtonState();
}

class _SignInWithAppleButtonState extends State<SignInWithAppleButton> {
  Future signinWithApple(BuildContext context) async {
    final User? firebaseUser = await context
        .read<AuthProvider>()
        .signinWithApple(onError: widget.onError);

    if (firebaseUser != null) return widget.onSuccess(firebaseUser);
    // widget.onError(firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HinokiButton(
          label: 'Sign ${widget.toggledText} with Apple',
          fullWidth: widget.fullWidth,
          color: 'black',
          type: 'border',
          onPressed: () {
            signinWithApple(context);
          },
        ),
        Positioned(
            left: 14,
            top: 0,
            bottom: 0,
            child: Container(
                width: 20,
                height: 20,
                child: Image(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  image: AssetImage('static/apple_icon.png'),
                )))
      ],
    );
  }
}
