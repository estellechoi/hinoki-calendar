import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/widgets/spinners/hinoki_spinner.dart';
import '../widgets/layouts/scaffold_layout.dart';
import 'package:flutter_app/widgets/buttons/text_label_button.dart';
import 'package:flutter_app/store/route_state.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../store/auth_provider.dart';
import 'package:health/health.dart';
import '../utils/health_data_controller.dart';
import '../store/route_state.dart';
import '../store/app_state.dart';
import '../widgets/styles/colors.dart' as colors;
import '../mixins/common.dart' as mixins;
import '../constants.dart' as constants;

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List<HealthDataPoint> _healthDataList = const [];

  Future<void> signout(AppState appState, AuthProvider authProvider) async {
    appState.startLoading();

    try {
      await authProvider.signout();
      await appState.logout();

      mixins.toast('Signed out');

      Future.delayed(constants.loadingDelayDuration, () {
        appState.endLoading();
        appState.goLoginView();
      });
    } catch (e) {
      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');

      mixins.toast('Failed to sign out.');

      Future.delayed(
          constants.loadingDelayDuration, () => appState.endLoading());
    }
  }

  Future<void> getAppleHealthKitData(AppState appState) async {
    appState.startLoading();

    HealthDataController _healthDataController =
        HealthDataController(HealthFactory());

    List<HealthDataPoint>? healthDataList =
        await _healthDataController.fetchHealthData();

    print('=============================================');
    print('[ASYNC DONE] HealthDataController.fetchHealthData');
    print('=============================================');
    print('');

    setState(() {
      _healthDataList = healthDataList ?? const [];
      appState.endLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, AuthProvider>(
        builder: (context, appState, authProvider, child) => Stack(
              children: <Widget>[
                ScaffoldLayout(
                    title: 'Profile',
                    refreshable: true,
                    body: SingleChildScrollView(
                        child: Container(
                            child: Column(
                      children: <Widget>[
                        TextLabelButton(
                          label: 'Sign out',
                          onPressed: () {
                            signout(appState, authProvider);
                          },
                        ),
                        TextLabelButton(
                          label: 'Fetch HealthKit Data',
                          onPressed: () {
                            getAppleHealthKitData(appState);
                          },
                        ),
                        Container(
                            child: Text(
                                'Total : ${_healthDataList.length} data fetched.')),
                        Column(children: printFetchedData(_healthDataList))
                      ],
                    )))),
                if (appState.isLoading) HinokiSpinner(color: colors.primary)
              ],
            ));
  }

  List<Widget> printFetchedData(data) {
    return [
      for (var item in data)
        Container(
            child: Column(
          children: <Widget>[
            // Text(item.toString()),
            Text('${item.typeString}: ${item.value}'),
            Text('${item.unitString}'),
            Text('${item.dateFrom} - ${item.dateTo}'),
            Text('-----------------------------------'),
          ],
        ))
    ];
  }
}
