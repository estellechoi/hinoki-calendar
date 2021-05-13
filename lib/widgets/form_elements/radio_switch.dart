import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/shadows.dart' as shadows;
import '../styles/borders.dart' as borders;
import '../styles/fonts.dart' as fonts;

class RadioSwitch extends StatefulWidget {
  final String type;
  final bool disabled;
  final Color rightActiveColor;
  final Color leftActiveColor;
  final List<String> labels;
  final bool isRightSelected;
  final ValueChanged<bool> onToggle;

  RadioSwitch(
      {Key? key,
      this.type = 'primary',
      this.disabled = false,
      this.rightActiveColor = colors.lightgrey,
      this.leftActiveColor = colors.lightgrey,
      required this.labels,
      required this.isRightSelected,
      required this.onToggle})
      : super(key: key);

  @override
  _RadioSwitchState createState() => _RadioSwitchState();
}

class _RadioSwitchState extends State<RadioSwitch>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);
  final double containerWidth = 80;
  final double containerHeight = 34.0;
  final double switchWidth = (80 - 4) / 2;
  final double switchHeight = 34 - 4;

  // states
  late final AnimationController _animationController;
  late final Animation _toggleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, value: widget.isRightSelected ? 1 : 0, duration: duration);

    _toggleAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(CurvedAnimation(
                curve: Curves.linear, parent: _animationController));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RadioSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isRightSelected != widget.isRightSelected) {
      widget.isRightSelected
          ? _animationController.forward()
          : _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
              onTap: () {
                if (!widget.disabled) {
                  widget.isRightSelected
                      ? _animationController.forward()
                      : _animationController.reverse();

                  widget.onToggle(!widget.isRightSelected);
                }
              },
              child: Container(
                  width: containerWidth,
                  height: containerHeight,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: widget.rightActiveColor,
                          borderRadius: borders.radiusLight,
                        ),
                      ),
                      AnimatedOpacity(
                          opacity: widget.isRightSelected ? 0 : 1,
                          duration: duration,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: containerWidth,
                            height: containerHeight,
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: widget.leftActiveColor,
                              borderRadius: borders.radiusLight,
                            ),
                          )),
                      Container(
                          child: Align(
                              alignment: _toggleAnimation.value,
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Container(
                                    width: switchWidth,
                                    height: switchHeight,
                                    decoration: BoxDecoration(
                                        color: colors.white,
                                        borderRadius: borders.radiusLight,
                                        boxShadow: shadows.tool),
                                  )))),
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            getOptionLabel(widget.labels[0]),
                            getOptionLabel(widget.labels[1])
                          ],
                        ),
                      )
                    ],
                  )));
        });
  }

  Widget getOptionLabel(String label) {
    return Container(
        width: switchWidth,
        height: switchHeight,
        alignment: Alignment.center,
        // decoration:
        //     BoxDecoration(border: borders.lightgrey),
        child:
            Text(label, style: TextStyle(color: colors.black, fontSize: 14)));
  }
}
