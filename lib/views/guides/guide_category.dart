import 'package:flutter/material.dart';
import '../../widgets/layouts/appbar_layout.dart';
import '../../widgets/styles/borders.dart' as borders;
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/fonts.dart' as fonts;
import '../../widgets/styles/shadows.dart' as shadows;
import '../../api/guides.dart' as api;
import '../../types/guide_category.dart';
import '../../app_state.dart';
import '../../route/pages.dart';
import '../../utils/format.dart' as format;

class GuideCategoryDetails extends StatefulWidget {
  @override
  _GuideCategoryDetailsState createState() => _GuideCategoryDetailsState();
}

// getGuideCategoryDetailsById

class _GuideCategoryDetailsState extends State<GuideCategoryDetails> {
  final String _id = appState.routeParam ?? '1';

  // States
  String _title = '';
  String _summary = '';
  String _preparation = '';
  String _purpose = '';
  String _imagePath = 'https://picsum.photos/250?image=9';
  List<dynamic> _contents = [];

  Future getGuideCategoryById() async {
    try {
      final data = await api.getGuideCategoryById(_id);
      GuideCategory details = GuideCategory.fromJson(data);

      setState(() {
        _title = details.title;
        _summary = details.summary;
        _preparation = details.preparation;
        _purpose = details.purpose;
        // _imagePath = details.imagePath;
        _imagePath = 'https://picsum.photos/250?image=9';
        _contents = details.contents;
      });
    } catch (e) {
      print(e);
    }
  }

  void goArticle(String id) {
    appState.pushNavigation(fetchGuideArticlePageConfig(id));
  }

  @override
  void initState() {
    super.initState();
    getGuideCategoryById();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarLayout(
        // globalKey: GlobalKey(),
        title: '',
        scrollController: ScrollController(),
        body: Container(
            child: Column(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 75 / 94,
                child: Container(
                    // clipBehavior: Clip.none,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: shadows.guideCategorySectionTitle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity,
                                minHeight: double.infinity),
                            child:
                                Image.network(_imagePath, fit: BoxFit.cover)),
                        Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity,
                                minHeight: double.infinity),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.0,
                                0.21,
                                0.75,
                                1.0,
                              ],
                              colors: [
                                colors.black,
                                colors.blackAlphaDeep,
                                colors.blackAlpha,
                                colors.transparent,
                              ],
                            )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(bottom: 142),
                                    child: Text(_title,
                                        style: TextStyle(
                                            color: colors.white,
                                            fontSize: fonts
                                                .sizeGuideCategorySectionTitle,
                                            fontWeight: fonts
                                                .weightGuideCategorySectionTitle,
                                            height: fonts
                                                .lineHeightGuideCategorySectionTitle))),
                                Container(
                                    child: Text('“',
                                        style: TextStyle(
                                            color: colors.white,
                                            fontSize: fonts
                                                .sizeGuideCategorySectionSummaryDeco,
                                            fontWeight: fonts
                                                .weightGuideCategorySectionSummaryDeco,
                                            height: fonts
                                                .lineHeightGuideCategorySectionSummaryDeco))),
                                Container(
                                    child: Text(_summary,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colors.white,
                                            fontSize: fonts
                                                .sizeGuideCategorySectionSummary,
                                            fontWeight: fonts
                                                .weightGuideCategorySectionSummary,
                                            height: fonts
                                                .lineHeightGuideCategorySectionSummary))),
                                Container(
                                    padding: EdgeInsets.only(top: 23),
                                    child: Text('”',
                                        style: TextStyle(
                                            color: colors.white,
                                            fontSize: fonts
                                                .sizeGuideCategorySectionSummaryDeco,
                                            fontWeight: fonts
                                                .weightGuideCategorySectionSummaryDeco,
                                            height: fonts
                                                .lineHeightGuideCategorySectionSummaryDeco))),
                              ],
                            ))
                      ],
                    ))),
            getDescription('준비사항', _preparation),
            getDescription('목적', _purpose),
            Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: colors.thickDividerBackground,
                    border: borders.sectionDividerBottom),
                child: Text('GUIDE',
                    style: TextStyle(
                        color: colors.thickDividerLabel,
                        fontSize: 15,
                        height: 1.2))),
            getArticles(_contents),
            SizedBox(height: 100)
          ],
        )));
  }

  Widget getArticles(List<dynamic> articles) {
    return Column(
        children: articles
            .asMap()
            .map((index, item) => MapEntry(
                index,
                getArticle(
                    format.prefixWithZero((index + 1).toString()),
                    item.id.toString(),
                    item.title,
                    item.imagePath,
                    item.isRead)))
            .values
            .toList());
  }

  Widget getDescription(String label, String value) {
    return Container(
        width: double.infinity,
        height: 106,
        decoration: BoxDecoration(border: borders.sectionDividerBottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(label,
                    style: TextStyle(
                        color: colors.sectionLabel,
                        fontSize: fonts.sizeBase,
                        fontWeight: fonts.weightBase,
                        height: 1.2))),
            Text(value,
                style: TextStyle(
                    color: colors.helperLabel,
                    fontSize: fonts.sizeModalDescription,
                    fontWeight: fonts.weightModalDescription,
                    height: fonts.lineHeightModalDescription)),
          ],
        ));
  }

  Widget getArticle(
      String index, String id, String title, String imagePath, bool isRead) {
    return GestureDetector(
        onTap: () {
          goArticle(id);
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: borders.sectionDividerBottom),
            child: IntrinsicHeight(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    child: Image.network(imagePath, fit: BoxFit.cover)),
                Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(index,
                        style: TextStyle(
                            color: colors.guideArticleListLabel,
                            fontSize: 15,
                            height: 1.2,
                            fontWeight: FontWeight.w700))),
                Expanded(
                    child: Container(
                  // width: double.infinity,
                  // height: double.infinity,
                  alignment: Alignment.centerLeft,
                  // clipBehavior: Clip.hardEdge,
                  child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colors.guideArticleListLabel,
                          fontSize: 15,
                          height: 1.2)),
                )),
                Container(
                    width: 66,
                    alignment: Alignment.center,
                    child: isRead ? Icon(Icons.check, size: 14) : Container()),
              ],
            ))));
  }
}
