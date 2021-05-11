import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_listview/infinite_listview.dart';
import './../styles/colors.dart' as colors;

class NumberSpinner extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;

  final double width;
  final int visibleItemCount;
  final int step;
  final bool useHaptics;
  final bool isInfinite;

  NumberSpinner(
      {Key? key,
      required this.minValue,
      required this.maxValue,
      required this.value,
      required this.onChanged,
      this.width = 100,
      this.visibleItemCount = 3,
      this.step = 1,
      this.useHaptics = false,
      this.isInfinite = false})
      : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  _NumberSpinnerState createState() => _NumberSpinnerState();
}

class _NumberSpinnerState extends State<NumberSpinner> {
  final double itemHeight = 40;
  late final ScrollController _scrollController;

  int get itemCount => (widget.maxValue - widget.minValue) ~/ widget.step + 1;
  int get additionalItemsOnEachSide => (widget.visibleItemCount - 1) ~/ 2;
  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;
  bool get isScrolling => _scrollController.position.isScrollingNotifier.value;

  @override
  void initState() {
    super.initState();
    final double initialOffset =
        ((widget.value - widget.minValue) ~/ widget.step * itemHeight)
            .toDouble();

    _scrollController = widget.isInfinite
        ? InfiniteScrollController(initialScrollOffset: initialOffset)
        : ScrollController(initialScrollOffset: initialOffset);

    _scrollController.addListener(_detectScroll);
  }

  @override
  void didUpdateWidget(NumberSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('-----------------------------------');
    print('didUpdateWidget');
    print(oldWidget.value);
    print(widget.value);
    print('-----------------------------------');

    if (oldWidget.value != widget.value) {
      print('detected !');
      _animateScroll();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _detectScroll() {
    var indexOfMiddleElement = (_scrollController.offset / itemHeight).round();

    if (widget.isInfinite) {
      indexOfMiddleElement %= itemCount;
    } else {
      indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    }

    final int intValueInTheMiddle =
        getIntValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);

    if (widget.value != intValueInTheMiddle) {
      widget.onChanged(intValueInTheMiddle);

      if (widget.useHaptics) {
        HapticFeedback.selectionClick();
      }
    }

    // Future.delayed(Duration(milliseconds: 100), () => _animateScroll());
  }

  void _animateScroll() {
    if (_scrollController.hasClients && !isScrolling) {
      int diff = widget.value - widget.minValue;
      int index = diff ~/ widget.step;

      print('_animateScroll');
      print(index);

      if (widget.isInfinite) {
        final offset = _scrollController.offset + 0.5 * itemHeight;
        final cycles = (offset / (itemCount * itemHeight)).floor();
        index += cycles * itemCount;
      }

      _scrollController.animateTo(
        index * itemHeight,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }

    // if (_scrollController.hasClients && !isScrolling) {
    //   int diff = widget.value - widget.minValue;
    //   int index = diff ~/ widget.step;

    //   if (widget.isInfinite) {
    //     final offset = _scrollController.offset + 0.5 * itemHeight;
    //     final cycles = (offset / (itemCount * itemHeight)).floor();
    //     index += cycles * itemCount;
    //   }

    //   _scrollController.animateTo(index * itemHeight,
    //       duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);
    // }
  }

  int getIntValueFromIndex(int index) {
    index -= additionalItemsOnEachSide;
    index %= itemCount;
    return widget.minValue + index * widget.step;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: itemHeight * widget.visibleItemCount,
        child: NotificationListener<ScrollEndNotification>(
            onNotification: (not) {
              if (not.dragDetails?.primaryVelocity == 0) {
                Future.microtask(() => _animateScroll());
              }

              return true;
            },
            child: Stack(
              children: <Widget>[
                widget.isInfinite
                    ? InfiniteListView.builder(
                        controller:
                            _scrollController as InfiniteScrollController,
                        itemExtent: itemHeight,
                        padding: EdgeInsets.zero,
                        itemBuilder: getItemBuiler)
                    : ListView.builder(
                        itemCount: listItemsCount,
                        controller: _scrollController,
                        itemExtent: itemHeight,
                        itemBuilder: getItemBuiler,
                        padding: EdgeInsets.zero),
                // Center(
                //   child: IgnorePointer(
                //       child: Container(
                //     width: double.infinity,
                //     height: itemHeight,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             width: 2,
                //             color: colors.active,
                //             style: BorderStyle.solid)),
                //   )),
                // )
              ],
            )));
  }

  Widget getItemBuiler(BuildContext context, int index) {
    final int value = getIntValueFromIndex(index % itemCount);
    final bool isExtra = !widget.isInfinite &&
        (index < additionalItemsOnEachSide ||
            index >= listItemsCount - additionalItemsOnEachSide);
    final Widget child = isExtra
        ? SizedBox.shrink()
        : Text(value.toString(),
            style:
                TextStyle(color: isScrolling ? colors.active : colors.black));

    return Container(
      child: child,
      width: widget.width,
      height: itemHeight,
      alignment: Alignment.center,
    );
  }
}
