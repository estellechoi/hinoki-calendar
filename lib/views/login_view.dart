import 'package:flutter/material.dart';
import '../api/auth.dart' as api;
import '../widgets/buttons/hinoki_button.dart';
import '../widgets/form_elements/linked_input.dart';
import '../widgets/buttons/f_button.dart';
import '../widgets/styles/paddings.dart' as paddings;
import '../widgets/styles/colors.dart' as colors;
import '../widgets/styles/fonts.dart' as fonts;
import '../app_state.dart';
import '../widgets/layouts/layout.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Map<String, String> formData = {'id': '', 'password': '', 'type': 'email'};

  void login() async {
    print('login data');
    print(formData.toString());
    try {
      await api.login(formData);
      await appState.getGuideUnreadCnt();
      appState.login();
    } catch (e) {
      // ...
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
                    child: Text('Hinoki',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colors.white,
                            fontFamily: fonts.primary,
                            fontFamilyFallback: fonts.primaryFallbacks,
                            height: 1.3,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3))),
                Column(
                  children: <Widget>[
                    LinkedInput(
                      position: 'top',
                      labelText: 'ID',
                      defaultValue: '',
                      onChanged: _changeId,
                    ),
                    LinkedInput(
                      type: 'password',
                      position: 'bottom',
                      labelText: 'Password',
                      defaultValue: '',
                      onChanged: _changePassword,
                    ),
                    SizedBox(height: 50),
                    Container(
                        child: HinokiButton(
                      // disabled: true,
                      fullWidth: true,
                      onPressed: login,
                      label: 'Create an account',
                    )),
                    SizedBox(height: 20),
                    Container(
                        child: HinokiButton(
                      type: 'border',
                      fullWidth: true,
                      // disabled: true,
                      onPressed: login,
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
