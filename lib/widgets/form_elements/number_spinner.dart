import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_listview/infinite_listview.dart';
import './../styles/colors.dart' as colors;
import './../styles/fonts.dart' as fonts;

class NumberSpinner extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;

  final bool disabled;
  final Color scrollingColor;
  final double width;
  final int visibleItemCount;
  final int step;
  final bool useHaptics;
  final bool isInfinite;
  final bool prefixZero;

  final onScroll;
  final onScrollEnd;

  NumberSpinner({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    required this.scrollingColor,
    this.disabled = false,
    this.width = 100,
    this.visibleItemCount = 3,
    this.step = 1,
    this.useHaptics = false,
    this.isInfinite = false,
    this.prefixZero = false,
    this.onScroll,
    this.onScrollEnd,
  })  : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  _NumberSpinnerState createState() => _NumberSpinnerState();
}

class _NumberSpinnerState extends State<NumberSpinner> {
  final double itemHeight = 34;
  late final ScrollController _scrollController;
  Color _labelColor = colors.black;

  @override
  void initState() {
    super.initState();

    final double initialOffset =
        (widget.value - widget.minValue) ~/ widget.step * itemHeight;

    _scrollController = widget.isInfinite
        ? InfiniteScrollController(initialScrollOffset: initialOffset)
        : ScrollController(initialScrollOffset: initialOffset);

    _scrollController.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(NumberSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _animateScroll();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (widget.disabled) return;

    _labelColor = widget.scrollingColor;

    var indexOfMiddleElement = (_scrollController.offset / itemHeight).round();

    if (widget.isInfinite) {
      indexOfMiddleElement %= itemCount;
    } else {
      indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    }

    final int intValueInTheMiddle =
        getIntValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);

    if (widget.value != intValueInTheMiddle) {
      if (widget.onScroll != null) widget.onScroll();
      widget.onChanged(intValueInTheMiddle);

      if (widget.useHaptics) {
        HapticFeedback.selectionClick();
      }
    }

    Future.delayed(Duration(milliseconds: 100), () => _animateScroll());
  }

  void _animateScroll() {
    if (_scrollController.hasClients && !isScrolling) {
      if (widget.onScrollEnd != null) widget.onScrollEnd();

      int diff = widget.value - widget.minValue;
      int index = diff ~/ widget.step;

      if (widget.isInfinite) {
        final offset = _scrollController.offset + 0.5 * itemHeight;
        final cycles = (offset / (itemCount * itemHeight)).floor();
        index += cycles * itemCount;
      }

      setState(() {
        _labelColor = colors.black;
      });

      _scrollController.animateTo(
        index * itemHeight,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  int getIntValueFromIndex(int index) {
    index -= additionalItemsOnEachSide;
    index %= itemCount;
    return widget.minValue + index * widget.step;
  }

  String getDisplayedValue(int value) {
    return widget.prefixZero
        ? value.toString().padLeft(widget.maxValue.toString().length, '0')
        : value.toString();
  }

  int get itemCount => (widget.maxValue - widget.minValue) ~/ widget.step + 1;
  int get additionalItemsOnEachSide => (widget.visibleItemCount - 1) ~/ 2;
  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;
  bool get isScrolling => _scrollController.position.isScrollingNotifier.value;

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
        : Text(getDisplayedValue(value),
            style: TextStyle(
                color: widget.disabled ? colors.disabled : _labelColor,
                fontSize: fonts.sizeBase));

    return Container(
      child: child,
      width: widget.width,
      height: itemHeight,
      alignment: Alignment.center,
    );
  }
}
