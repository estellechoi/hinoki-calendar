import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;

class FRange extends StatefulWidget {
  final ValueChanged<double>? onChanged;
  final double rating;
  final double min;
  final double max;
  final int? divisions;
  final bool showLabel;

  FRange(
      {Key? key,
      required this.onChanged,
      required this.rating,
      this.min = 0.0,
      this.max = 1.0,
      this.divisions,
      this.showLabel = false})
      : super(key: key);

  @override
  _FRangeState createState() => _FRangeState();
}

class _FRangeState extends State<FRange> {
  @override
  Widget build(BuildContext context) {
    String? _label = widget.showLabel ? '${widget.rating}' : null;

    return SliderTheme(
        data: SliderThemeData(
            trackHeight: 10.0,
            activeTrackColor: colors.primaryHigh,
            inactiveTrackColor: colors.primaryHighAlpha,
            activeTickMarkColor: colors.transparent,
            inactiveTickMarkColor: colors.transparent,
            thumbColor: colors.primaryHigh,
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 6.0, elevation: 0, pressedElevation: 0),
            overlayColor: colors.transparent,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0)),
        child: Slider(
          onChanged: widget.onChanged,
          value: widget.rating,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          label: _label,
          // activeColor: colors.primaryHigh,
        ));
  }
}
