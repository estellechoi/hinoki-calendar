import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/form_elements/f_input.dart';
import '../../widgets/texts/input_label.dart';
import '../../widgets/form_elements/f_switch_advanced.dart';
import '../../widgets/form_elements/f_range_advanced.dart';
import '../../widgets/buttons/f_button.dart';
import '../../widgets/texts/helper_label.dart';
import '../../widgets/styles/paddings.dart' as paddings;
import '../../widgets/layouts/appbar_layout.dart';
import '../../store/route_state.dart';
import '../../api/record.dart' as api;
import '../../types/daily_body_record.dart';
import '../../utils/format.dart' as date;
import '../../store/app_state.dart';

// EXAMPLE WIDGET
class RecordBody extends StatefulWidget {
  RecordBody();

  @override
  _RecordBodyState createState() => _RecordBodyState();
}

class _RecordBodyState extends State<RecordBody> {
  late final String _selectedDate;
  late Future<dynamic> _getData;

  // fetched/posting states
  double _bloodSugar = 0;
  double _ketoneValue = 0;
  double _appetite = 0;
  double _condition = 0;
  String _measurementType = 'breath';
  String _intake = '';
  String _memo = '';
  double _height = 0;
  double _weight = 0;
  // sub states
  bool _isEditMode = false;

  AppState get appState => Provider.of<AppState>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _selectedDate = appState.routeState.routeParam ??
        date.stringifyDateTime(DateTime.now());
    _getData = getDailyBodyRecord();
  }

  Future<dynamic> keepData() async {
    return DailyBodyRecord(
        appetite: _appetite,
        bloodSugar: _bloodSugar,
        condition: _condition,
        ketoneValue: _ketoneValue,
        height: _height,
        weight: _weight,
        intake: _intake,
        measurementDay: _selectedDate,
        measurementType: _measurementType,
        memo: _memo,
        isEditMode: _isEditMode);
  }

  Future<dynamic> getDailyBodyRecord() async {
    try {
      final Map<String, String> param = {'measurement_day': _selectedDate};
      final data = await api.getDailyBodyRecord(param);
      DailyBodyRecord record = DailyBodyRecord.fromJson(data);
      _isEditMode = record.isEditMode;
      return record;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future deleteDailyBodyRecord() async {
    try {
      final Map<String, String> param = {'measurement_day': _selectedDate};
      await api.deleteDailyBodyRecord(param);
      appState.goBack(true);
    } catch (e) {
      print(e);
    }
  }

  void refreshData() {
    _getData = keepData();
  }

  void deleteData() {
    print('deleteData');
    deleteDailyBodyRecord();
  }

  void _changeRecordMethod(bool isActive) {
    setState(() {
      _measurementType = isActive ? 'breath' : 'blood';
      refreshData();
    });
  }

  void _printInput(String text) {
    print(text);
  }

  void _changeAppetite(double value) {
    setState(() {
      _appetite = value;
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarLayout(
        // globalKey: GlobalKey(),
        title: '?????? ??????',
        scrollController: ScrollController(),
        body: Container(
            padding: EdgeInsets.symmetric(
                vertical: paddings.verticalBase,
                horizontal: paddings.horizontalBase),
            child: FutureBuilder(
                future: _getData,
                builder: (BuildContext buildContext,
                    AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    bool isBreath = snapshot.data.measurementType == 'breath';

                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FInput(
                              hintText: '????????? ???????????????',
                              labelText: '??????',
                              defaultValue: snapshot.data.weight.toString(),
                              onChanged: _printInput,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formFieldSub),
                            child: FInput(
                              hintText: '????????? ???????????????',
                              labelText: '????????????',
                              defaultValue:
                                  snapshot.data.ketoneValue.toString(),
                              onChanged: _printInput,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formFieldSub),
                            child: FSwitchAdvanced(
                                label: '???????????? ??????????',
                                inactiveText: '??????',
                                activeText: '??????',
                                isActive: isBreath,
                                onToggle: _changeRecordMethod),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: HelperLabel(
                                text:
                                    '* ??????????????? ????????? ???????????? ??????????????? ???????????? ????????????. ????????? ??????????????? ??????????????? ?????? ??????????????? ???????????????.'),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FInput(
                              hintText: '????????? ???????????????',
                              labelText: '????????????',
                              defaultValue: snapshot.data.bloodSugar.toString(),
                              onChanged: _printInput,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  bottom: paddings.formFieldLabel),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InputLabel(text: '??????'))),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FRangeAdvanced(
                                onChanged: _changeAppetite,
                                rating: snapshot.data.appetite,
                                max: 10.0,
                                divisions: 10,
                                showLabel: true),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  bottom: paddings.formFieldLabel),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: InputLabel(text: '?????????'))),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FRangeAdvanced(
                                onChanged: _changeAppetite,
                                rating: snapshot.data.appetite,
                                max: 10.0,
                                divisions: 10,
                                showLabel: true),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FInput(
                              type: 'textarea',
                              hintText: '',
                              labelText: '?????? ????????? ???',
                              defaultValue: snapshot.data.intake,
                              onChanged: _printInput,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddings.formField),
                            child: FInput(
                              type: 'textarea',
                              hintText: '',
                              labelText: '?????? (??????, ???????????? ??????)',
                              defaultValue: snapshot.data.memo,
                              onChanged: _printInput,
                            ),
                          ),
                          buildButtons(snapshot.data.isEditMode)
                        ]);
                  } else {
                    // go back ...
                    // routeState.goBack(null);
                    return Container();
                  }
                })));
  }

  Widget buildButtons(bool isEditMode) {
    return isEditMode
        ? Container(
            // padding: EdgeInsets.only(bottom: paddings.formField),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Expanded(
                    child: FButton(
                  // disabled: true,
                  type: 'blue',
                  onPressed: deleteData,
                  text: '??????',
                )),
                SizedBox(width: 10.0),
                Expanded(
                    child: FButton(
                  // disabled: true,
                  onPressed: () {
                    debugPrint('Button Pressed !');
                  },
                  text: '??????',
                ))
              ]))
        : Container(
            // padding: EdgeInsets.only(bottom: paddings.formField),
            child: FButton(
            // disabled: true,
            fullWidth: true,
            onPressed: () {
              debugPrint('Button Pressed !');
            },
            text: '??????',
          ));
  }
}
