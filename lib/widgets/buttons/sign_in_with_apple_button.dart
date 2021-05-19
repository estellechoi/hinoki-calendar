import 'package:flutter/material.dart';
import '../../utils/auth_provider.dart';
import './../buttons/hinoki_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInWithAppleButton extends StatefulWidget {
  final ValueChanged<User?> onSuccess;
  final onError;
  final bool fullWidth;

  SignInWithAppleButton(
      {required this.onSuccess, required this.onError, this.fullWidth = false});

  @override
  _SignInWithAppleButtonState createState() => _SignInWithAppleButtonState();
}

class _SignInWithAppleButtonState extends State<SignInWithAppleButton> {
  Future signinWithApple(BuildContext context) async {
    final User? firebaseUser = await context
        .read<AuthProvider>()
        .signinWithApple(onError: widget.onError);
    // await context.read<AuthProvider>().signinWithApple();
    widget.onSuccess(firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    return HinokiButton(
      label: 'Sign in with Apple',
      fullWidth: widget.fullWidth,
      onPressed: () {
        signinWithApple(context);
      },
    );
  }
}
