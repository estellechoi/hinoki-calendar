import 'package:flutter/material.dart';
import './../styles/colors.dart' as colors;
import './../styles/borders.dart' as borders;
import './../styles/fonts.dart' as fonts;
import './../../mixins/common.dart' as mixins;
import './../../widgets/modals/center_modal_sheet.dart';
import 'time_picker.dart';

class HinokiTimePicker extends StatefulWidget {
  final int defaultHour;
  final int defaultMinute;
  final bool isPMSelected;
  final ValueChanged<List<int>> onTimeSelected;
  final ValueChanged<bool> onZoneToggle;

  HinokiTimePicker(
      {required this.defaultHour,
      required this.defaultMinute,
      this.isPMSelected = false,
      required this.onTimeSelected,
      required this.onZoneToggle});

  @override
  _HinokiTimePickerState createState() => _HinokiTimePickerState();
}

class _HinokiTimePickerState extends State<HinokiTimePicker> {
  int _selectedHour = 1;
  int _selectedMinute = 0;

  bool _isPMSelected = false;

  String get selectedZone => _isPMSelected ? 'PM' : 'AM';
  String get label => '$_selectedHour : $_selectedMinute $selectedZone';

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.defaultHour;
    _selectedMinute = widget.defaultMinute;
    _isPMSelected = widget.isPMSelected;
  }

  void _handleTimeSelection(List<int> timeset) {
    setState(() {
      _selectedHour = timeset[0];
      _selectedMinute = timeset[1];
    });

    widget.onTimeSelected(timeset);
  }

  void _handleZoneToggle(bool isPMSelected) {
    setState(() {
      _isPMSelected = isPMSelected;
    });

    widget.onZoneToggle(_isPMSelected);
  }

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
                children: <Widget>[
                  TimePicker(
                      defaultHour: widget.defaultHour,
                      defaultMinute: widget.defaultMinute,
                      isPMSelected: widget.isPMSelected,
                      onTimeSelected: _handleTimeSelection,
                      onZoneToggle: _handleZoneToggle)
                ],
              )))),
    );
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
            child: Text(label,
                style: TextStyle(
                    color: colors.active, fontSize: fonts.sizeBase))));
  }
}
