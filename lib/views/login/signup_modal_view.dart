import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/views/login/signup_form.dart';
import '../../app_state.dart';
import '../../route/pages.dart';
import '../../api/auth.dart' as api;
import '../../widgets/buttons/hinoki_button.dart';
import '../../widgets/buttons/sign_in_with_apple_button.dart';

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
  void handleSuccess(User? firebaseUser) {
    print('---------------------------------------');
    print('Firebase login success');
    print(firebaseUser);
    print('---------------------------------------');

    appState.login();
  }

  void handleError(Object error) {
    print('---------------------------------------');
    print('Firebase login fail');
    print(error);
    print('---------------------------------------');
  }

  @override
  Widget build(BuildContext context) {
    String toggledText = widget.isSignin ? 'in' : 'up';

    return Column(
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
                child: HinokiButton(
                  fullWidth: true,
                  type: 'border',
                  color: 'black',
                  label: 'Sign $toggledText with Google',
                  onPressed: () {},
                )),
            Platform.isIOS
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: SignInWithAppleButton(
                        fullWidth: true,
                        toggledText: toggledText,
                        onSuccess: handleSuccess,
                        onError: handleError))
                : Container(),
            Container(
                margin: EdgeInsets.only(bottom: 40),
                child: HinokiButton(
                  fullWidth: true,
                  type: 'border',
                  color: 'black',
                  label: 'Sign $toggledText with Email',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              SignupForm(isSignin: widget.isSignin)),
                    );
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
                                widget.onToggled();
                                Navigator.pop(context);
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
    );
  }
}
