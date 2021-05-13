import 'package:flutter/material.dart';
import 'time_spinner.dart';
import 'radio_switch.dart';

class TimePicker extends StatefulWidget {
  final int defaultHour;
  final int defaultMinute;
  final bool isPMSelected;
  final ValueChanged<List<int>> onTimeSelected;
  final ValueChanged<bool> onZoneToggle;

  TimePicker(
      {required this.defaultHour,
      required this.defaultMinute,
      this.isPMSelected = false,
      required this.onTimeSelected,
      required this.onZoneToggle});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  bool _isPMSelected = false;

  @override
  void initState() {
    super.initState();
    _isPMSelected = widget.isPMSelected;
  }

  void _onToggle(bool isPMSelected) {
    setState(() {
      _isPMSelected = isPMSelected;
    });

    widget.onZoneToggle(_isPMSelected);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Row(
      children: <Widget>[
        TimeSpinner(
          defaultHour: widget.defaultHour,
          defaultMinute: widget.defaultMinute,
          onChanged: widget.onTimeSelected,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: RadioSwitch(
              labels: ['AM', 'PM'],
              isRightSelected: _isPMSelected,
              onToggle: _onToggle),
        )
      ],
    ));
  }
}
