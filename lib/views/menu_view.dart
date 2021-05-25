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
  List<HealthDataPoint> _healthDataList = const [];

  Future signoutFirebase(BuildContext context) async {
    await context.read<AuthProvider>().signout();
    appState.logout();
  }

  Future<void> getAppleHealthKitData() async {
    List<HealthDataPoint>? healthDataList =
        await healthData.fetchAppleHealthKit();

    print(healthDataList);

    setState(() {
      _healthDataList = healthDataList ?? const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: SingleChildScrollView(
            child: Container(
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
        ),
        Container(
            child: Text('Total : ${_healthDataList.length} data fetched.')),
        Container(child: printFetchedData())
      ],
    ))));
  }

  Widget printFetchedData() {
    return Column(
      children: <Widget>[
        for (var _healthDataPoint in _healthDataList)
          Container(
              child: Column(
            children: <Widget>[
              Text('${_healthDataPoint.typeString}: ${_healthDataPoint.value}'),
              Text('${_healthDataPoint.unitString}'),
              Text('${_healthDataPoint.dateFrom} - ${_healthDataPoint.dateTo}')
            ],
          ))
      ],
    );
  }
}
