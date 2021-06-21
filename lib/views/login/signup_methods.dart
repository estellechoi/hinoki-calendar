import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../../store/app_state.dart';
import '../../types/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/views/login/signup_form.dart';
import 'package:flutter_app/widgets/spinners/hinoki_spinner.dart';
import '../../store/route_state.dart';
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

class SignupMethods extends StatefulWidget {
  final VoidCallback onToggled;
  final bool isSignin;

  SignupMethods({required this.onToggled, this.isSignin = false});

  @override
  _SignupMethodsState createState() => _SignupMethodsState();
}

class _SignupMethodsState extends State<SignupMethods> {
  void _handleFirebaseAuthStart(BuildContext context) {
    final AppState appState = context.read<AppState>();
    appState.startLoading();
  }

  void _handleFirebaseAuthFinish(UserCredential? authResult) {
    // need context parameter ?
    final AppState appState = context.read<AppState>();
    appState.endLoading();

    print('---------------------------------------');
    print('Firebase login finished : UserCredential');
    print(authResult);
    print('---------------------------------------');

    AppUser appUser = AppUser(
        id: 1,
        accessToken: '',
        name: 'Test User',
        birthday: '',
        gender: 0,
        phoneNum: '01000000000');
    appState.login(appUser);

    Navigator.pop(context);
  }

  AppState get appState => Provider.of<AppState>(context, listen: false);

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
    return Consumer<AppState>(
        builder: (context, appState, child) => Stack(
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
                                style: TextStyle(
                                    color: colors.black, fontSize: 34))),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: SignInWithGoogleButton(
                                fullWidth: true,
                                toggledText: toggledText,
                                onPressed: () {
                                  _handleFirebaseAuthStart(context);
                                },
                                onFinished: _handleFirebaseAuthFinish)),
                        Platform.isIOS
                            ? Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: SignInWithAppleButton(
                                    fullWidth: true,
                                    toggledText: toggledText,
                                    onPressed: () {
                                      _handleFirebaseAuthStart(context);
                                    },
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
                                        text: widget.isSignin
                                            ? 'Sign up'
                                            : 'Sign in',
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
                                          text:
                                              'By Signing up, you agree to our ',
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
                if (appState.isLoading) HinokiSpinner(color: colors.primary)
              ],
            ));
  }
}