import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/shadows.dart' as shadows;
import '../styles/borders.dart' as borders;

// import '../../constants.dart';

class FSwitch extends StatefulWidget {
  final String type;
  final bool disabled;
  final bool isActive;
  final bool showText;
  final String activeText;
  final String inactiveText;
  final ValueChanged<bool> onToggle;

  final Duration duration = const Duration(milliseconds: 200);
  final double textSize = 14.0;
  final String activeTextDefault = 'On';
  final String inactiveTextDefault = 'Off';
  final double textSpace = 40.0;
  final double containerWidth = 112.0;
  final double containerHeight = 28.0;
  final double switchWidth = 50.0;
  final double switchHeight = 20.0;

  FSwitch(
      {Key? key,
      this.type = 'primary',
      this.disabled = false,
      required this.isActive,
      this.showText = false,
      this.activeText = '',
      this.inactiveText = '',
      required this.onToggle})
      : super(key: key);

  @override
  _FSwitchState createState() => _FSwitchState();
}

class _FSwitchState extends State<FSwitch> with SingleTickerProviderStateMixin {
  late final Color _containerColor;
  late final Color _activeColor;
  late final Color _inactiveColor;
  late final Animation _toggleAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Styles
    _containerColor = widget.type == 'primary' ? colors.white : colors.white;

    _activeColor =
        widget.type == 'primary' ? colors.primaryHigh : colors.primaryHigh;

    _inactiveColor =
        widget.type == 'primary' ? colors.primaryHigh : colors.disabled;

    // Animation
    _animationController = AnimationController(
        vsync: this,
        value: widget.isActive ? 1.0 : 0.0,
        duration: widget.duration);

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
  void didUpdateWidget(covariant FSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive == widget.isActive) return;

    widget.isActive
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Color _switchColor = Colors.white;
    _switchColor = widget.isActive ? _activeColor : _inactiveColor;

    // Builder
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    if (!widget.disabled) {
                      widget.isActive
                          ? _animationController.forward()
                          : _animationController.reverse();

                      widget.onToggle(!widget.isActive);
                    }
                  },
                  child: Opacity(
                      opacity: widget.disabled ? 0.6 : 1.0,
                      child: Container(
                          width: widget.containerWidth,
                          height: widget.containerHeight,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              borderRadius: borders.radiusRound,
                              border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: _switchColor),
                              color: _containerColor),
                          child: Stack(
                            children: <Widget>[
                              // Texts
                              AnimatedOpacity(
                                  opacity: widget.isActive ? 1.0 : 0.0,
                                  duration: widget.duration,
                                  child: Container(
                                      width: widget.textSpace,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      alignment: Alignment.centerLeft,
                                      child: _activeText)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: AnimatedOpacity(
                                      opacity: widget.isActive ? 0.0 : 1.0,
                                      duration: widget.duration,
                                      child: Container(
                                          width: widget.textSpace,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          alignment: Alignment.centerRight,
                                          child: _inactiveText))),
                              // Switch
                              Container(
                                  child: Align(
                                      alignment: _toggleAnimation.value,
                                      child: Container(
                                          width: widget.switchWidth,
                                          height: widget.switchHeight,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              color: _switchColor,
                                              borderRadius: borders.radiusRound,
                                              boxShadow: shadows.tool))))
                            ],
                          )))));
        });
  }

  Widget get _activeText {
    if (widget.showText) {
      return Text(
          widget.activeText.length > 0
              ? widget.activeText
              : widget.activeTextDefault,
          style: TextStyle(color: _activeColor, fontSize: widget.textSize));
    }

    return Text('');
  }

  Widget get _inactiveText {
    if (widget.showText) {
      return Text(
          widget.inactiveText.length > 0
              ? widget.inactiveText
              : widget.inactiveTextDefault,
          style: TextStyle(color: _inactiveColor, fontSize: widget.textSize));
    }

    return Text('');
  }
}
