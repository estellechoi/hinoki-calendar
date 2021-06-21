import 'package:flutter/material.dart';
import '../../widgets/styles/colors.dart' as colors;
import '../../animations/delay_tween.dart';

class HinokiSpinner extends StatefulWidget {
  final Color color;
  final String size;

  HinokiSpinner({
    this.color = colors.primary,
    this.size = 'normal',
  });

  @override
  _HinokiSpinnerState createState() => _HinokiSpinnerState();
}

class _HinokiSpinnerState extends State<HinokiSpinner>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _animationController;
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat()
          ..forward();

    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _isSpinning = true;
      });
    });
  }

  @override
  void dispose() {
    // setState(() {
    //   _isSpinning = false;
    // });

    _animationController.dispose();

    // Future.delayed(Duration(milliseconds: 50), () {
    // });

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedOpacity(
        opacity: _isSpinning ? 1 : 0,
        duration: Duration(milliseconds: 1000),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: colors.whiteAlphaDeep),
            ),
            Center(
              child: SizedBox.fromSize(
                  size: Size(100, 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (i) {
                        return ScaleTransition(
                            scale: DelayTween(begin: 0, end: 1, delay: i * 0.2)
                                .animate(_animationController),
                            child: SizedBox.fromSize(
                                size: Size.square(16),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: widget.color,
                                        shape: BoxShape.circle))));
                      }))),
            )
          ],
        ));
  }
}
