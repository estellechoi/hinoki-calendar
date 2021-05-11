import 'package:flutter/material.dart';
import './../styles/colors.dart' as colors;
import './../styles/borders.dart' as borders;
import './../styles/fonts.dart' as fonts;
import './../../mixins/common.dart' as mixins;
import './../../widgets/modals/center_modal_sheet.dart';
import 'time_picker.dart';

class HinokiTimePicker extends StatefulWidget {
  final String defaultTime;

  HinokiTimePicker({required this.defaultTime});

  @override
  _HinokiTimePickerState createState() => _HinokiTimePickerState();
}

class _HinokiTimePickerState extends State<HinokiTimePicker> {
  String _selectedTime = '';

  Future _openTimePicker(BuildContext context) async {
    double dialogWidth = MediaQuery.of(context).size.width * (4 / 5);
    // double dialogHeight = dialogWidth * 1.1;

    await mixins.openDialog(
      context: context,
      child: CenterModalSheet(
          child: Container(
              width: dialogWidth,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              child: IntrinsicHeight(
                  // height: dialogHeight,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[TimePicker()],
              )))),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.defaultTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _openTimePicker(context);
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            decoration: BoxDecoration(
                color: colors.lightgrey, borderRadius: borders.radiusLight),
            child: Text(_selectedTime,
                style: TextStyle(
                    color: colors.active, fontSize: fonts.sizeBase))));
  }
}
