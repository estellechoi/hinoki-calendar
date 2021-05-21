import 'package:flutter/material.dart';

import '../widgets/buttons/hinoki_button.dart';
import '../widgets/styles/colors.dart' as colors;
import '../widgets/styles/fonts.dart' as fonts;
import '../widgets/layouts/layout.dart';
import './../mixins/common.dart' as mixins;
import 'login/signup_modal_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final int modalToggleDuration = 600;

  Future openSignupDialog(BuildContext context) async {
    await mixins.openTitledBottomModal(
        context: context,
        intrinsicHeight: false,
        title: 'Create an account',
        backButtonLabel: 'Cancel',
        child: SignupModalView(onToggled: () {
          Future.delayed(Duration(milliseconds: modalToggleDuration),
              () => openSigninDialog(context));
        }),
        onCanceled: () {},
        onRightButtonClicked: () {});
  }

  Future openSigninDialog(BuildContext context) async {
    await mixins.openTitledBottomModal(
        context: context,
        intrinsicHeight: false,
        title: 'Sign in',
        backButtonLabel: 'Cancel',
        child: SignupModalView(
            isSignin: true,
            onToggled: () {
              Future.delayed(Duration(milliseconds: modalToggleDuration),
                  () => openSignupDialog(context));
            }),
        onCanceled: () {},
        onRightButtonClicked: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: colors.active),
            child: Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              image: AssetImage('static/sky.jpeg'),
            )),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                        width: 160,
                        height: 32,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                        decoration: BoxDecoration(
                          color: colors.whiteAlphaLight,
                          // border: Border.all(
                          //     width: 3,
                          //     style: BorderStyle.solid,
                          //     color: colors.white)
                        ),
                        child: Text('Hinoki',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.whiteAlphaDeep,
                              fontFamily: fonts.primary,
                              fontFamilyFallback: fonts.primaryFallbacks,
                              height: 1.3,
                              fontSize: 46,
                              fontWeight: FontWeight.w700,
                            ))),
                    Container(
                        width: 160,
                        height: 46,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                        decoration: BoxDecoration(
                          color: colors.whiteAlphaLight,
                          // border: Border.all(
                          //     width: 3,
                          //     style: BorderStyle.solid,
                          //     color: colors.white)
                        ),
                        child: Text('Hinoki',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.whiteAlphaDeep,
                              fontFamily: fonts.primary,
                              fontFamilyFallback: fonts.primaryFallbacks,
                              height: 1.3,
                              fontSize: 46,
                              fontWeight: FontWeight.w700,
                            )))
                  ],
                )),
                Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Text(
                          'Simplify your days.\n'
                          'Discover productivity.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colors.white,
                              fontSize: 26,
                              fontFamily: fonts.primary,
                              fontFamilyFallback: fonts.primaryFallbacks),
                        )),
                    Container(
                        child: HinokiButton(
                      // disabled: true,
                      fullWidth: true,
                      onPressed: () {
                        openSignupDialog(context);
                      },
                      label: 'Create an account',
                    )),
                    SizedBox(height: 20),
                    Container(
                        child: HinokiButton(
                      type: 'border',
                      color: 'white',
                      fullWidth: true,
                      // disabled: true,
                      onPressed: () {
                        openSigninDialog(context);
                      },
                      label: 'I already have an account',
                    ))
                  ],
                )
              ],
            ))
      ],
    ));
  }
}
