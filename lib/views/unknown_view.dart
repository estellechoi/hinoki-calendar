import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import './../widgets/layouts/layout.dart';
import './../widgets/spinners/hinoki_spinner.dart';
import './../widgets/styles/colors.dart' as colors;
import './../widgets/styles/fonts.dart' as fonts;

class UnknownView extends StatefulWidget {
  @override
  _UnknownViewState createState() => _UnknownViewState();
}

class _UnknownViewState extends State<UnknownView> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text('Sorry, something went wrong !',
                      style: TextStyle(
                          color: colors.blackAlphaDeep,
                          fontWeight: FontWeight.w400,
                          fontFamily: fonts.primary,
                          fontFamilyFallback: fonts.primaryFallbacks,
                          fontSize: 22)),
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Force restart the app
                        },
                      text: 'Tap here to try again',
                      style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w400,
                          fontFamily: fonts.primary,
                          fontFamilyFallback: fonts.primaryFallbacks,
                          fontSize: 18,
                          decoration: TextDecoration.underline)),
                  TextSpan(
                      text: ' or ',
                      style: TextStyle(
                          color: colors.blackAlphaDeep,
                          fontWeight: FontWeight.w400,
                          fontFamily: fonts.primary,
                          fontFamilyFallback: fonts.primaryFallbacks,
                          fontSize: 16)),
                  TextSpan(
                      text: 'Restart the app.',
                      style: TextStyle(
                          color: colors.blackAlphaDeep,
                          fontWeight: FontWeight.w400,
                          fontFamily: fonts.primary,
                          fontFamilyFallback: fonts.primaryFallbacks,
                          fontSize: 16)),
                ]))
              ],
            )));
  }
}
