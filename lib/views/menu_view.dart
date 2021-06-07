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
import './../utils/health_data.dart' as healthData;
import '../store/route_state.dart';
import '../store/app_state.dart';
import '../widgets/styles/colors.dart' as colors;

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  bool _isLoading = false;
  List<HealthDataPoint> _healthDataList = const [];

  AppState get appState => Provider.of<AppState>(context, listen: false);

  Future signoutFirebase(BuildContext context) async {
    await context.read<AuthProvider>().signout();
    appState.goLoginView();
  }

  Future<void> getAppleHealthKitData() async {
    toggleLoading(true);

    List<HealthDataPoint>? healthDataList =
        await healthData.fetchAppleHealthKit();

    print(healthDataList);

    Future.delayed(Duration(milliseconds: 3000), () {
      toggleLoading(false);

      setState(() {
        _healthDataList = healthDataList ?? const [];
      });
    });
  }

  void toggleLoading(bool val) {
    setState(() {
      _isLoading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    child: Text(
                        'Total : ${_healthDataList.length} data fetched.')),
                Column(children: printFetchedData(_healthDataList))
              ],
            )))),
        if (_isLoading) HinokiSpinner(color: colors.primary)
      ],
    );
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
