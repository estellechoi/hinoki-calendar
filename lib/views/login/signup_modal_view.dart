import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/views/login/signup_form.dart';
import 'package:flutter_app/widgets/spinners/hinoki_spinner.dart';
import '../../app_state.dart';
import '../../route/pages.dart';
import '../../api/auth.dart' as api;
import '../../widgets/buttons/hinoki_button.dart';
import '../../widgets/buttons/sign_in_with_apple_button.dart';
import '../../widgets/buttons/sign_in_with_google_button.dart';

import '../../widgets/form_elements/linked_input.dart';
import '../../widgets/form_elements/common/shadowed_bundle.dart';
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/textstyles.dart' as textstyles;
import '../../widgets/styles/borders.dart' as borders;

class SignupModalView extends StatefulWidget {
  final VoidCallback onToggled;
  final bool isSignin;

  SignupModalView({required this.onToggled, this.isSignin = false});

  @override
  _SignupModalViewState createState() => _SignupModalViewState();
}

class _SignupModalViewState extends State<SignupModalView> {
  bool _isLoading = false;

  void _toggleLoading(bool val) {
    setState(() {
      _isLoading = val;
    });
  }

  void _handleFirebaseAuthStart() {
    _toggleLoading(true);
  }

  void _handleFirebaseAuthFinish(UserCredential? authResult) {
    _toggleLoading(false);

    print('---------------------------------------');
    print('Firebase login finished : UserCredential');
    print(authResult);
    print('---------------------------------------');

    appState.login();
    Navigator.pop(context);
  }

  void openSignupForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => SignupForm(
              isSignin: widget.isSignin,
              onSuccess: () {
                Navigator.pop(context);
                Navigator.pop(context);
              })),
    );
  }

  void toggleMode(BuildContext context) {
    widget.onToggled();
    Navigator.pop(context);
  }

  String get toggledText => widget.isSignin ? 'in' : 'up';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 0, bottom: 40),
                    child: Text('...',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.black, fontSize: 34))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: SignInWithGoogleButton(
                        fullWidth: true,
                        toggledText: toggledText,
                        onPressed: _handleFirebaseAuthStart,
                        onFinished: _handleFirebaseAuthFinish)),
                Platform.isIOS
                    ? Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: SignInWithAppleButton(
                            fullWidth: true,
                            toggledText: toggledText,
                            onPressed: _handleFirebaseAuthStart,
                            onFinished: _handleFirebaseAuthFinish))
                    : Container(),
                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: HinokiButton(
                      fullWidth: true,
                      type: 'border',
                      color: 'black',
                      label: 'Sign $toggledText with Email',
                      onPressed: () {
                        openSignupForm(context);
                      },
                    )),
                Container(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: colors.disabled),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.isSignin
                                      ? "Don't have an account? "
                                      : 'Already have an account? ',
                                  style: textstyles.helpText),
                              TextSpan(
                                text: widget.isSignin ? 'Sign up' : 'Sign in',
                                style: textstyles.strongHelpText,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    toggleMode(context);
                                  },
                              )
                            ])))
              ],
            )),
            widget.isSignin
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 30, bottom: 0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: colors.disabled),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'By Signing up, you agree to our ',
                                  style: textstyles.comment),
                              TextSpan(
                                text: 'Terms of Service',
                                style: textstyles.strongComment,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Open Browser to see ..
                                  },
                              ),
                              TextSpan(
                                  text: ' and acknowledge that our ',
                                  style: textstyles.comment),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: textstyles.strongComment,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Open Browser to see ..
                                  },
                              ),
                              TextSpan(
                                  text: ' applies to you.',
                                  style: textstyles.comment),
                            ])))
          ],
        ),
        if (_isLoading) HinokiSpinner(color: colors.primary)
      ],
    );
  }
}
