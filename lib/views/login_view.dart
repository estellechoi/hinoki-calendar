import 'package:flutter/material.dart';
import '../api/auth.dart' as api;
import '../widgets/form_elements/f_input.dart';
import '../widgets/buttons/f_button.dart';
import '../widgets/styles/paddings.dart' as paddings;
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
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: paddings.verticalBase,
                horizontal: paddings.horizontalBase),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: paddings.formField),
                        child: FInput(
                          hintText: '아이디',
                          defaultValue: '',
                          onChanged: _changeId,
                        )),
                    Container(
                        padding: EdgeInsets.only(
                          bottom: paddings.formField,
                        ),
                        child: FInput(
                          type: 'password',
                          hintText: '비밀번호',
                          defaultValue: '',
                          onChanged: _changePassword,
                        )),
                    Container(
                        // padding: EdgeInsets.only(bottom: paddings.formField),
                        child: FButton(
                      // disabled: true,
                      fullWidth: true,
                      onPressed: login,
                      text: '로그인',
                    ))
                  ],
                ))));
  }
}
