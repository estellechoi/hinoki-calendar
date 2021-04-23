import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/paddings.dart' as paddings;
import '../cards/section_card.dart';

class ScrollSlider extends StatefulWidget {
  final List<dynamic> items;
  final double width;
  final double height;
  final double gap;
  final double margin;
  final bool showLabel;
  final bool showBottomLabel;
  final onItemTap;

  ScrollSlider(
      {this.items = const [],
      required this.width,
      required this.height,
      this.gap = 0,
      this.margin = 0,
      this.showLabel = true,
      this.showBottomLabel = false,
      this.onItemTap});

  @override
  _ScrollSliderState createState() => _ScrollSliderState();
}

class _ScrollSliderState extends State<ScrollSlider> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.items
              .asMap()
              .map((index, item) => MapEntry(
                  index,
                  IntrinsicHeight(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            if (widget.onItemTap != null)
                              widget.onItemTap(item);
                          },
                          child: Container(
                              clipBehavior: Clip.none,
                              width: widget.width,
                              height: widget.height,
                              margin: EdgeInsets.only(
                                  right: index == (widget.items.length - 1)
                                      ? widget.margin
                                      : widget.gap,
                                  left: index == 0 ? widget.margin : 0),
                              decoration: BoxDecoration(
                                  color: colors.white,
                                  borderRadius: borders.radiusLight),
                              child: SectionCard(
                                authorizedAt: item.authorizedAt ?? '',
                                title: item.title ?? '',
                                summary: item.label ?? '',
                                imagePath: 'https://picsum.photos/250?image=9',
                                isLock: item.isLock ?? false,
                                isRead: item.isRead ?? false,
                                showLabel: widget.showLabel,
                              ))),
                      widget.showBottomLabel
                          ? Container(
                              width: widget.width,
                              height: 26,
                              margin: EdgeInsets.only(
                                  right: index == (widget.items.length - 1)
                                      ? widget.margin
                                      : widget.gap,
                                  left: index == 0 ? widget.margin : 0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(item.title ?? '',
                                    style: TextStyle(
                                        color: colors.sectionLabel,
                                        fontSize:
                                            fonts.sizeCardSliderBottomTitle)),
                              ))
                          : Container(height: 0)
                    ],
                  ))))
              .values
              .toList(),
        ));
  }
}
