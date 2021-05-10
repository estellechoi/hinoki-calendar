import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/shadows.dart' as shadows;
import '../styles/borders.dart' as borders;

// import '../../constants.dart';

class HinokiSwitch extends StatefulWidget {
  final String type;
  final bool disabled;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  HinokiSwitch(
      {Key? key,
      this.type = 'primary',
      this.disabled = false,
      required this.isActive,
      required this.onToggle})
      : super(key: key);

  @override
  _HinokiSwitchState createState() => _HinokiSwitchState();
}

class _HinokiSwitchState extends State<HinokiSwitch>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);
  final double containerWidth = 48.0;
  final double containerHeight = 28.0;
  final double switchWidth = 24.0;
  final double switchHeight = 24.0;

  // states
  late final AnimationController _animationController;
  late final Animation _toggleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, value: widget.isActive ? 1 : 0, duration: duration);

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
  void didUpdateWidget(covariant HinokiSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive != widget.isActive) {
      widget.isActive
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
                  widget.isActive
                      ? _animationController.forward()
                      : _animationController.reverse();

                  widget.onToggle(!widget.isActive);
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
                          color: colors.active,
                          borderRadius: borders.radiusCircle,
                        ),
                      ),
                      AnimatedOpacity(
                          opacity: widget.isActive ? 0 : 1,
                          duration: duration,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: containerWidth,
                            height: containerHeight,
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: colors.lightgrey,
                              borderRadius: borders.radiusCircle,
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
                                      borderRadius: borders.radiusCircle,
                                    ),
                                  ))))
                    ],
                  )));
        });
  }
}
