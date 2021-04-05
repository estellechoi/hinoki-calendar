import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;
import '../styles/sizes.dart' as sizes;

class FBarChart extends StatefulWidget {
  final String color;

  FBarChart({Key? key, this.color = 'primary'}) : super(key: key);

  @override
  _FBarChartState createState() => _FBarChartState();
}

class _FBarChartState extends State<FBarChart> {
  @override
  Widget build(BuildContext context) {
    Color _color = colors.primaryHigh;

    switch (widget.color) {
      case 'primary':
        _color = colors.primaryHigh;
        break;
      case 'sugar':
        _color = colors.sugarChart;
        break;
      case 'blood':
        _color = colors.bloodChart;
        break;
      case 'keton':
        _color = colors.ketonChart;
        break;
      default:
        _color = colors.primaryHigh;
    }

    return AspectRatio(
        aspectRatio: 1.6,
        child: Container(
            child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 30.0),
                Expanded(
                    child: BarChart(getBarChartData(_color),
                        swapAnimationDuration: Duration(milliseconds: 250)))
              ],
            )
          ],
        )));
  }

  BarChartData getBarChartData(_color) {
    return BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: colors.transparent,
                tooltipPadding: EdgeInsets.all(0),
                tooltipMargin: 8.0,
                getTooltipItem: (BarChartGroupData group, int groupIndex,
                    BarChartRodData rod, int rodIndex) {
                  return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                          color: colors.inputText,
                          fontSize: fonts.sizeTooltip,
                          fontWeight: fonts.weightBase));
                })),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (val) {
                return TextStyle(
                    color: colors.black,
                    fontWeight: fonts.weightChartAxis,
                    fontSize: fonts.sizeChartAxis);
              },
              margin: 30,
              getTitles: (double val) {
                switch (val.toInt()) {
                  case 1:
                    return '06.01';
                  case 2:
                    return '06.02';
                  case 3:
                    return '06.03';
                  case 4:
                    return '06.04';
                  case 5:
                    return '06.05';
                  default:
                    return '';
                }
              },
            ),
            leftTitles: SideTitles(showTitles: false)),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(y: 1, colors: [_color])
          ], showingTooltipIndicators: [
            1
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(y: 2, colors: [_color])
          ], showingTooltipIndicators: [
            1
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(y: 3, colors: [_color])
          ], showingTooltipIndicators: [
            1
          ]),
          BarChartGroupData(x: 4, barRods: [
            BarChartRodData(y: 4, colors: [_color])
          ], showingTooltipIndicators: [
            1
          ]),
          BarChartGroupData(x: 5, barRods: [
            BarChartRodData(y: 5, colors: [_color])
          ], showingTooltipIndicators: [
            1
          ]),
        ]);
  }
}
