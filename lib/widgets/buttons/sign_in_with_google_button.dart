import 'package:flutter/material.dart';
import '../../utils/auth_provider.dart';
import './../buttons/hinoki_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart' as colors;

class SignInWithGoogleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ValueChanged<UserCredential?> onFinished;
  final bool fullWidth;
  final String toggledText;

  SignInWithGoogleButton(
      {required this.onPressed,
      required this.onFinished,
      this.fullWidth = false,
      this.toggledText = 'in'});

  @override
  _SignInWithGoogleButtonState createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  Future signinWithGoogle(BuildContext context) async {
    final UserCredential? authResult =
        await context.read<AuthProvider>().signinWithGoogle();

    widget.onFinished(authResult);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HinokiButton(
          label: 'Sign ${widget.toggledText} with Google',
          fullWidth: widget.fullWidth,
          color: 'black',
          type: 'border',
          onPressed: () {
            widget.onPressed();
            signinWithGoogle(context);
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
                  image: AssetImage('static/google_icon.png'),
                )))
      ],
    );
  }
}
