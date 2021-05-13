import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/borders.dart' as borders;
import '../styles/fonts.dart' as fonts;
import 'number_spinner.dart';

class TimeSpinner extends StatefulWidget {
  final int defaultHour;
  final int defaultMinute;

  TimeSpinner({required this.defaultHour, required this.defaultMinute});

  @override
  _TimeSpinnerState createState() => _TimeSpinnerState();
}

class _TimeSpinnerState extends State<TimeSpinner> {
  int _selectedHour = 0;
  int _selectedMinute = 0;

  bool _isScrolling = false;
  Color _borderColor = colors.transparent;

  bool _isHourDisabled = false;
  bool _isMinuteDisabled = false;

  @override
  void initState() {
    super.initState();

    _selectedHour = widget.defaultHour;
    _selectedMinute = widget.defaultMinute;
  }

  void _handleScroll(String type) {
    setState(() {
      if (!_isScrolling) {
        switch (type) {
          case 'hour':
            _isMinuteDisabled = true;
            break;
          case 'minute':
            _isHourDisabled = true;
            break;
        }

        _borderColor = colors.active;
        _isScrolling = true;
      }
    });
  }

  void _handleScrollEnd(String type) {
    setState(() {
      if (_isScrolling) {
        switch (type) {
          case 'hour':
            _isMinuteDisabled = false;
            break;
          case 'minute':
            _isHourDisabled = false;
            break;
        }

        _borderColor = colors.transparent;
        _isScrolling = false;
      }
    });
  }

  void _changeHour(int value) {
    setState(() {
      _selectedHour = value;
    });
  }

  void _changeMinute(int value) {
    setState(() {
      _selectedMinute = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double cellWidth = 40;

    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Container(
                clipBehavior: Clip.hardEdge,
                width: 86,
                decoration: BoxDecoration(
                    color: colors.lightgrey,
                    border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: _borderColor),
                    borderRadius: borders.radiusBase),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NumberSpinner(
                      disabled: _isHourDisabled,
                      useHaptics: true,
                      isInfinite: true,
                      prefixZero: true,
                      scrollingColor: colors.active,
                      visibleItemCount: 1,
                      width: cellWidth,
                      minValue: 1,
                      maxValue: 12,
                      value: _selectedHour,
                      onScroll: () {
                        _handleScroll('hour');
                      },
                      onScrollEnd: () {
                        _handleScrollEnd('hour');
                      },
                      onChanged: _changeHour,
                    ),
                    SizedBox(
                        width: 4,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(':',
                                style: TextStyle(
                                    fontSize: fonts.sizeBase,
                                    color: _isHourDisabled || _isMinuteDisabled
                                        ? colors.disabled
                                        : colors.black)))),
                    NumberSpinner(
                      disabled: _isMinuteDisabled,
                      useHaptics: true,
                      isInfinite: true,
                      prefixZero: true,
                      scrollingColor: colors.active,
                      visibleItemCount: 1,
                      width: cellWidth,
                      minValue: 0,
                      maxValue: 59,
                      value: _selectedMinute,
                      onScroll: () {
                        _handleScroll('minute');
                      },
                      onScrollEnd: () {
                        _handleScrollEnd('minute');
                      },
                      onChanged: _changeMinute,
                    )
                  ],
                ))));
  }
}
