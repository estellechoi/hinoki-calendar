import 'package:flutter/material.dart';
import 'index.dart';
import 'package:flutter_app/widgets/buttons/text_label_button.dart';
import 'package:flutter_app/app_state.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './../utils/auth_provider.dart';
import 'package:health/health.dart';
import './../utils/health_data.dart' as healthData;

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  Future signoutFirebase(BuildContext context) async {
    await context.read<AuthProvider>().signout();
    appState.logout();
  }

  Future<void> getAppleHealthKitData() async {
    List<HealthDataPoint>? healthDataList =
        await healthData.fetchAppleHealthKit();

    print('----------------------------- Apple HealthKit Data Fetched');
    print(healthDataList);
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: Container(
            child: Column(
      children: <Widget>[
        TextLabelButton(
          label: 'Sign out',
          onPressed: () {
            signoutFirebase(context);
          },
        ),
        TextLabelButton(
          label: 'Fetch HealthKit Data',
          onPressed: () {
            getAppleHealthKitData();
          },
        )
      ],
    )));
  }
}
