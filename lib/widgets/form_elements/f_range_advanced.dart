import 'package:flutter/material.dart';
import 'f_range.dart';
import '../styles/textstyles.dart' as textstyles;
import '../styles/paddings.dart' as paddings;

class FRangeAdvanced extends StatefulWidget {
  final ValueChanged<double>? onChanged;
  final double rating;
  final double min;
  final double max;
  final int? divisions;
  final bool showLabel;

  FRangeAdvanced(
      {Key? key,
      required this.onChanged,
      required this.rating,
      this.min = 0.0,
      this.max = 1.0,
      this.divisions,
      this.showLabel = false})
      : super(key: key);

  @override
  _FRangeAdvancedState createState() => _FRangeAdvancedState();
}

class _FRangeAdvancedState extends State<FRangeAdvanced> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FRange(
        onChanged: widget.onChanged,
        rating: widget.rating,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        showLabel: widget.showLabel,
      ),
      Container(
          padding: EdgeInsets.only(top: paddings.rangeHelper),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(widget.rating.toInt().toString(),
                    style: textstyles.rangeHelperText),
              ),
              Text(widget.max.toInt().toString(),
                  style: textstyles.rangeHelperMaxText)
            ],
          ))
    ]);
  }
}
