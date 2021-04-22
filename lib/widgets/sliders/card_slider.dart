import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/paddings.dart' as paddings;

class CardItem {
  final String title;
  final String summary;
  final String imagePath;

  CardItem({
    required this.title,
    required this.summary,
    required this.imagePath,
  });
}

class CardSlider extends StatefulWidget {
  final List<dynamic> items;
  final double viewportFraction;
  final double height;
  final double gap;
  final bool showLabel;
  final bool isHorizontal;
  final onPageChanged;

  CardSlider({
    this.items = const [],
    required this.viewportFraction,
    required this.height,
    required this.gap,
    required this.showLabel,
    this.isHorizontal = true,
    this.onPageChanged,
  });

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  @override
  Widget build(BuildContext context) {
    List<CardItem> cardItems = widget.items.map((item) {
      return CardItem(
        title: item.title ?? '',
        summary: '${item.contents.length}개의 가이드 / 초보자 필독',
        imagePath: 'https://picsum.photos/250?image=9',
      );
    }).toList();

    return CarouselSlider(
      options: CarouselOptions(
          // If you pass the height parameter, the aspectRatio parameter will be ignored.
          height: widget.height,
          // aspectRatio: 16 / 9,
          viewportFraction: widget.viewportFraction,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          onPageChanged: widget.onPageChanged,
          scrollDirection:
              widget.isHorizontal ? Axis.horizontal : Axis.vertical,
          disableCenter: true),
      items: cardItems
          .asMap()
          .map((index, item) => MapEntry(index, Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.only(left: index == 0 ? 0 : widget.gap),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: borders.radiusLight),
                      child: Stack(children: <Widget>[
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: borders.radiusLight),
                            constraints: BoxConstraints(
                                minWidth: double.infinity,
                                minHeight: double.infinity),
                            child: Image.network(item.imagePath,
                                fit: BoxFit.cover)),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: colors.blackAlpha,
                              borderRadius: borders.radiusLight),
                          constraints: BoxConstraints(
                              minWidth: double.infinity,
                              minHeight: double.infinity),
                        ),
                        widget.showLabel
                            ? Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                    padding: EdgeInsets.only(
                                      left: paddings.cardSlider,
                                      bottom: paddings.cardSlider,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                              color: colors.white,
                                              fontSize:
                                                  fonts.sizeCardSliderTitle,
                                              fontWeight: fonts.weightBase,
                                              height: fonts.lineHeightBase),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          item.summary,
                                          style: TextStyle(
                                              color: colors.white,
                                              fontSize:
                                                  fonts.sizeCardSliderSummary),
                                        ),
                                      ],
                                    )))
                            : Container()
                      ]));
                },
              )))
          .values
          .toList(),
    );
  }
}
