import 'package:flutter/material.dart';
import './../styles/colors.dart' as colors;
import './../styles/borders.dart' as borders;
import 'number_spinner.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  List<int> hours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List<int> mins = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  Widget build(BuildContext context) {
    int _selectedHour = 10;
    int _selectedMinute = 25;

    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Container(
                clipBehavior: Clip.hardEdge,
                width: 110,
                decoration: BoxDecoration(
                  color: colors.lightgrey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NumberSpinner(
                      useHaptics: true,
                      visibleItemCount: 1,
                      width: 50,
                      minValue: 1,
                      maxValue: 12,
                      value: _selectedHour,
                      onChanged: (int value) {
                        setState(() {
                          _selectedHour = value;
                        });
                      },
                    ),
                    SizedBox(
                        width: 10,
                        child: Align(
                            alignment: Alignment.center, child: Text(':'))),
                    NumberSpinner(
                      useHaptics: true,
                      visibleItemCount: 1,
                      width: 50,
                      minValue: 1,
                      maxValue: 59,
                      value: _selectedMinute,
                      onChanged: (int value) {
                        setState(() {
                          _selectedMinute = value;
                        });
                      },
                    )
                  ],
                ))));
  }
}
