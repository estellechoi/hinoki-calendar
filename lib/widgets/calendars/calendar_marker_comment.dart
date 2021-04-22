import 'package:flutter/material.dart';
import '../styles/fonts.dart' as fonts;
import '../styles/sizes.dart' as sizes;
import '../styles/paddings.dart' as paddings;
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/shadows.dart' as shadows;

class CalendarMarkerComment extends StatefulWidget {
  final String label;
  final String type;

  CalendarMarkerComment({
    Key? key,
    required this.label,
    required this.type,
  }) : super(key: key);

  @override
  _CalendarMarkerCommentState createState() => _CalendarMarkerCommentState();
}

class _CalendarMarkerCommentState extends State<CalendarMarkerComment> {
  Color _labelColor = colors.inputText;
  Color _iconColor = colors.white;
  Border _iconBorder = borders.calendarStrongCell;
  BorderRadius _iconBorderRadius = borders.radiusCircle;
  List<BoxShadow> _boxShadow = shadows.calendarStrongcell;

  String _iconText = '';

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case 'main':
        _labelColor = colors.calendarMarkerComment;
        break;
      case 'range':
        _labelColor = colors.helperLabel;
        _iconColor = colors.calendarRangeColoredCell;
        _iconBorder = borders.none;
        _boxShadow = [];
        break;
      case 'colored-text':
        _labelColor = colors.calendarColoredCell;
        _iconColor = colors.transparent;
        _iconBorder = borders.none;
        _iconText = '#';
        _boxShadow = [];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: sizes.calendarMarkerCommentIcon,
                height: sizes.calendarMarkerCommentIcon,
                decoration: BoxDecoration(
                    color: _iconColor,
                    boxShadow: _boxShadow,
                    border: _iconBorder,
                    borderRadius: _iconBorderRadius),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(_iconText,
                        style: TextStyle(color: colors.calendarColoredCell))))),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding:
                  EdgeInsets.only(left: paddings.calendarMarkerCommentIcon),
              child: Text(widget.label,
                  style: TextStyle(
                      color: _labelColor,
                      fontSize: fonts.sizeHelper,
                      height: fonts.lineHeightHelper)),
            ))
      ],
    );
  }
}
