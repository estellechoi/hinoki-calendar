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
import '../../mixins/common.dart' as mixins;
import '../../constants.dart' as constants;

class SignupMethods extends StatefulWidget {
  final VoidCallback onToggled;
  final bool isSignin;

  SignupMethods({required this.onToggled, this.isSignin = false});

  @override
  _SignupMethodsState createState() => _SignupMethodsState();
}

class _SignupMethodsState extends State<SignupMethods> {
  void _handleFirebaseAuthStart(AppState appState) {
    // final AppState appState = context.read<AppState>();
    appState.startLoading();

    print('=============================================');
    print('[FUNC CALL] SignupMethods._handleFirebaseAuthStart');
    print('=============================================');
    print('');
  }

  Future<void> _handleFirebaseAuthFinish(
      AppState appState, UserCredential? userCredential) async {
    print('=============================================');
    print('[FUNC CALL] SignupMethods._handleFirebaseAuthFinish');
    print('=============================================');
    print('');

    if (userCredential == null) {
      mixins.toast('Sign ${widget.isSignin ? 'in' : 'up'} Process Terminated');

      Future.delayed(
          constants.loadingDelayDuration, () => appState.endLoading());

      return;
    }

    final AdditionalUserInfo? additionalUserInfo =
        userCredential.additionalUserInfo;
    final User? user = userCredential.user;
    final AuthCredential? authCredential = userCredential.credential;

    if (authCredential != null) {
      print('=============================================');
      print('* Provider Id : ${authCredential.providerId}');
      print('=============================================');
      print('');
    }

    if (additionalUserInfo != null) {
      print('=============================================');
      print('* is New User : ${additionalUserInfo.isNewUser}');
      print('* Profile Picture : ${additionalUserInfo.profile?['picture']}');
      print('* Family Name : ${additionalUserInfo.profile?['family_name']}');
      print('* Given Name : ${additionalUserInfo.profile?['given_name']}');
      print('* Email : ${additionalUserInfo.profile?['email']}');
      print(
          '* Email Verified : ${additionalUserInfo.profile?['email_verified']}');
      print('=============================================');
      print('');
    }

    if (user != null) {
      print('=============================================');
      print('* Display Name : ${user.displayName}');
      print('* is Anonymous : ${user.isAnonymous}');
      print('* Email Verified : ${user.emailVerified}');
      print('* Creation Time : ${user.metadata.creationTime}');
      print('* Last Sign In Time : ${user.metadata.lastSignInTime}');
      print('=============================================');
      print('');
    }

    try {
      final bool isNewUser = additionalUserInfo?.isNewUser ?? true;

      if (isNewUser) {
        // 자동 회원가입 API Call ...

      } else {
        // id, pw 없이 자동 로그인 API Call ...
      }

      AppUser appUser = AppUser(
          id: 1,
          accessToken: '',
          name: 'Test User',
          birthday: '',
          gender: 0,
          phoneNum: '01000000000');

      await appState.login(appUser);

      if (widget.isSignin && isNewUser)
        mixins.toast('Auto-signed up as could not find your account');
      else if (!widget.isSignin && !isNewUser)
        mixins.toast('Already signed up !');
      else
        mixins.toast('Signed ${widget.isSignin ? 'in' : 'up'}');

      Future.delayed(constants.loadingDelayDuration, () {
        appState.endLoading();
        Navigator.pop(context);
        appState.goHomeView();
      });
    } catch (e) {
      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');

      mixins.toast('Failed to sign ${widget.isSignin ? 'in' : 'up'} .');

      Future.delayed(
          constants.loadingDelayDuration, () => appState.endLoading());
    }
  }

  void openSignupForm(AppState appState) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => SignupForm(
              isSignin: widget.isSignin,
              onSuccess: () {
                Navigator.pop(context);
                Navigator.pop(context);
                appState.goHomeView();
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
                                  _handleFirebaseAuthStart(appState);
                                },
                                onFinished: (userCredential) {
                                  _handleFirebaseAuthFinish(
                                      appState, userCredential);
                                })),
                        Platform.isIOS
                            ? Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: SignInWithAppleButton(
                                    fullWidth: true,
                                    toggledText: toggledText,
                                    onPressed: () {
                                      _handleFirebaseAuthStart(appState);
                                    },
                                    onFinished: (userCredential) {
                                      _handleFirebaseAuthFinish(
                                          appState, userCredential);
                                    }))
                            : Container(),
                        Container(
                            margin: EdgeInsets.only(bottom: 40),
                            child: HinokiButton(
                              fullWidth: true,
                              type: 'border',
                              color: 'black',
                              label: 'Sign $toggledText with Email',
                              onPressed: () {
                                openSignupForm(appState);
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
