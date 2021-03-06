import 'package:flutter/material.dart';
import './../styles/colors.dart' as colors;
import './../styles/borders.dart' as borders;
import './../styles/fonts.dart' as fonts;
import './../../mixins/common.dart' as mixins;
import './../../widgets/modals/center_modal_sheet.dart';
import './../calendars/date_picker_calendar.dart';

class HinokiDatePicker extends StatefulWidget {
  final String defaultDate;
  final ValueChanged<String> onDaySelected;

  HinokiDatePicker({required this.defaultDate, required this.onDaySelected});

  @override
  _HinokiDatePickerState createState() => _HinokiDatePickerState();
}

class _HinokiDatePickerState extends State<HinokiDatePicker> {
  String _selectedDate = '';

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.defaultDate;
  }

  Future _openDatePicker(BuildContext context) async {
    final double dialogWidth = MediaQuery.of(context).size.width * (4 / 5);
    final double dialogHeight = dialogWidth * 1.1;

    await mixins.openDialog(
      context: context,
      child: CenterModalSheet(
          child: Container(
              width: dialogWidth,
              height: dialogHeight,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: DatePickerCalendar(
                    defaultDate: widget.defaultDate,
                    onPageChanged: (String date) {},
                    onDaySelected: (String date, int weekday) {
                      setState(() {
                        _selectedDate = date;
                      });

                      widget.onDaySelected(date);
                    },
                  ))
                ],
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _openDatePicker(context);
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            decoration: BoxDecoration(
                color: colors.lightgrey, borderRadius: borders.radiusLight),
            child: Text(_selectedDate,
                style: TextStyle(
                    color: colors.active, fontSize: fonts.sizeBase))));
  }
}
