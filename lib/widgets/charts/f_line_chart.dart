import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;
import '../styles/sizes.dart' as sizes;

class FLineChart extends StatefulWidget {
  @override
  _FLineChartState createState() => _FLineChartState();
}

class _FLineChartState extends State<FLineChart> {
  bool _displayData = false;

  @override
  void initState() {
    super.initState();
    _displayData = false;
  }

  void _handleTouch(LineTouchResponse touchResponse) {
    // ...
  }

  void _toggleDisplay() {
    setState(() {
      _displayData = !_displayData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: LineChart(getLineChartData(),
                              swapAnimationDuration:
                                  Duration(milliseconds: 250))))
                ],
              ),
              // IconButton(
              //     icon: Icon(Icons.refresh, color: colors.black),
              //     onPressed: _toggleDisplay)
            ],
          ),
        ));
  }

  LineChartData getLineChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipPadding:
                EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            tooltipBgColor: colors.transparent,
          ),
          touchCallback: _handleTouch,
          handleBuiltInTouches: true,
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                  FlLine(
                      color: colors.primaryHighAlpha,
                      strokeWidth: sizes.lineChartDotLineStrokeWidth),
                  FlDotData(getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                    radius: sizes.lineChartDot,
                    color: colors.primaryHigh,
                    strokeWidth: sizes.lineChartDotStrokeWidth,
                    strokeColor: colors.primaryHigh);
              }));
            }).toList();
          }),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
            showTitles: true,
            // reservedSize: 22,
            getTextStyles: (val) => TextStyle(
                color: colors.inputText,
                fontWeight: fonts.weightChartAxis,
                fontSize: fonts.sizeChartAxis),
            margin: 30,
            getTitles: (val) {
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
              }
              return '';
            }),
        leftTitles: SideTitles(
          showTitles: false,
          // getTextStyles: (val) => TextStyle(
          //     color: colors.inputText,
          //     fontWeight: fonts.weightBase,
          //     fontSize: fonts.sizeBase),
          // getTitles: (val) {
          //   return '';
          // },
          // margin: 0,
          // reservedSize: 0
        ),
      ),
      borderData: FlBorderData(show: true, border: borders.none),
      // minX: 0,
      // maxX: 1,
      // minY: 0,
      // maxY: 1,
      lineBarsData: getLineBarsData(),
    );
  }

  List<LineChartBarData> getLineBarsData() {
    final LineChartBarData lineChartBarData = LineChartBarData(
        spots: [
          FlSpot(1, 61.4),
          FlSpot(2, 60.7),
          FlSpot(3, 60.5),
          FlSpot(4, 60.3),
          FlSpot(5, 59.7)
        ],
        // showingIndicators: [1, 2, 3, 4, 5],
        isCurved: true,
        colors: [colors.primaryHigh],
        barWidth: 2.0,
        isStrokeCapRound: true,
        dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              if (index == 0) {
                debugPrint('getDotPainter - spot');
                debugPrint(spot.toString());
                debugPrint('getDotPainter - percent');
                debugPrint(percent.toString());
                debugPrint('getDotPainter - barData');
                debugPrint(barData.toString());
                debugPrint('getDotPainter - index');
                debugPrint(index.toString());
              }
              return FlDotCirclePainter(
                  radius: sizes.lineChartDot,
                  color: colors.white,
                  strokeWidth: sizes.lineChartDotStrokeWidth,
                  strokeColor: colors.primaryHigh);
            }),
        belowBarData: BarAreaData(show: false));

    return [lineChartBarData];
  }
}
