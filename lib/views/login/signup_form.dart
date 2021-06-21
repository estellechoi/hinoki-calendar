import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../../store/route_state.dart';
import '../../store/app_state.dart';
import '../../types/app_user.dart';
import '../../api/auth.dart' as api;
import '../../widgets/layouts/appbar_layout.dart';
import '../../widgets/buttons/hinoki_button.dart';
import '../../widgets/form_elements/linked_input.dart';
import '../../widgets/form_elements/common/shadowed_bundle.dart';
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/textstyles.dart' as textstyles;
import '../../widgets/styles/fonts.dart' as fonts;
import '../../widgets/styles/sizes.dart' as sizes;
import '../../widgets/spinners/hinoki_spinner.dart';
import '../../mixins/common.dart' as mixins;

class SignupForm extends StatefulWidget {
  final bool isSignin;
  final onSuccess;

  SignupForm({required this.isSignin, required this.onSuccess});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final Map<String, String> formData = {
    'id': '',
    'password': '',
    'type': 'email'
  };

  // AppState get appState => Provider.of<AppState>(context, listen: false);

  Future<void> _login(BuildContext context) async {
    final AppState appState = context.read<AppState>();
    appState.startLoading();

    try {
      print(formData);
      final data = await api.login(formData);
      AppUser appUser = AppUser.fromJson(data);

      appState.endLoading();
      appState.login(appUser);

      mixins.toast('Signed ${widget.isSignin ? 'in' : 'up'}!');
      Future.delayed(Duration(milliseconds: 1100), () => widget.onSuccess());
    } catch (e) {
      appState.endLoading();
      mixins.toast('Failed to sign ${widget.isSignin ? 'in' : 'up'}.');

      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');
    }
  }

  void _changeId(String text) {
    setState(() {
      formData['id'] = text;
    });
  }

  void _changePassword(String text) {
    setState(() {
      formData['password'] = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String toggleText = widget.isSignin ? 'in' : 'up';

    return Consumer<AppState>(
        builder: (context, appState, child) => Stack(
              children: <Widget>[
                AppBarLayout(
                    extendBodyBehindAppBar: true,
                    title: '',
                    scrollController: ScrollController(),
                    // globalKey: GlobalKey(),
                    body: Container(
                        height: sizes.screenHeight(context),
                        padding: EdgeInsets.only(
                          top: sizes.appBar * 2,
                          bottom: 30,
                          left: 26,
                          right: 26,
                        ),
                        decoration: BoxDecoration(
                          color: colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                // decoration: BoxDecoration(border: borders.primaryDeco),
                                child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 40),
                                    child: Text('Sign $toggleText with email.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colors.black,
                                            fontSize: 20,
                                            fontFamily: fonts.primary,
                                            fontFamilyFallback:
                                                fonts.primaryFallbacks))),
                                ShadowedInputBundle(
                                  children: <Widget>[
                                    LinkedInput(
                                      position: 'top',
                                      labelText: 'Email',
                                      defaultText: '',
                                      onChanged: _changeId,
                                    ),
                                    LinkedInput(
                                      type: 'password',
                                      position: 'bottom',
                                      labelText: 'Password',
                                      defaultText: '',
                                      onChanged: _changePassword,
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: HinokiButton(
                                      fullWidth: true,
                                      type: 'filled',
                                      color: 'primary',
                                      label: widget.isSignin
                                          ? 'Sign in'
                                          : 'Create an account',
                                      onPressed: () {
                                        FocusScope.of(context).unfocus(
                                            disposition:
                                                UnfocusDisposition.scope);
                                        _login(context);
                                      },
                                    )),
                              ],
                            )),
                            Container(
                                // margin: EdgeInsets.only(top: 30, bottom: 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style:
                                            TextStyle(color: colors.disabled),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'By Signing up, you agree to our ',
                                              style: textstyles.fadedComment),
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: textstyles.comment,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Open Browser to see ..
                                              },
                                          ),
                                          TextSpan(
                                              text:
                                                  ' and acknowledge that our ',
                                              style: textstyles.fadedComment),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: textstyles.comment,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Open Browser to see ..
                                              },
                                          ),
                                          TextSpan(
                                              text: ' applies to you.',
                                              style: textstyles.fadedComment),
                                        ])))
                          ],
                        ))),
                if (appState.isLoading) HinokiSpinner(color: colors.primary)
              ],
            ));
  }
}
