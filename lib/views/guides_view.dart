import 'package:flutter/material.dart';
import 'package:flutter_app/types/guide_category.dart';
import 'index.dart';
import '../app_state.dart';
import '../route/pages.dart';
import '../widgets/sliders/card_slider.dart';
import '../widgets/sliders/scroll_slider.dart';

import '../widgets/texts/section_label.dart';
import '../widgets/styles/paddings.dart' as paddings;
import '../widgets/styles/borders.dart' as borders;
import '../api/guides.dart' as api;
import '../types/guides_tree_data.dart';
import '../app_state.dart';
import '../types/guide_content.dart';
import 'mixins/guides.dart' as mixins;

class GuidesView extends StatefulWidget {
  @override
  _GuidesViewState createState() => _GuidesViewState();
}

class _GuidesViewState extends State<GuidesView> {
  List<dynamic> _categorySet1 = [];
  List<dynamic> _categorySet2 = [];

  Future getGuideCategories() async {
    try {
      final data = await api.getGuideCategories();
      GuidesTreeData record = GuidesTreeData.fromJson(data);
      print(record);

      setState(() {
        _categorySet1 =
            record.categories.where((item) => item.categoryId < 3).map((item) {
          return GuideCategory(
              categoryId: item.categoryId,
              contents: item.contents,
              imagePath: item.imagePath,
              isLock: item.isLock,
              preparation: item.preparation,
              purpose: item.purpose,
              summary: item.summary,
              title: item.title,
              id: item.categoryId,
              label: '${item.contents.length}개의 가이드 / 초보자 필독');
        }).toList();

        _categorySet2 =
            record.categories.where((item) => item.categoryId >= 3).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void goCategoryDetails(GuideCategory category) {
    print('goCategoryDetails');
    print(category.id);
    appState
        .pushNavigation(fetchGuideCategoryPageConfig(category.id.toString()));
  }

  void _goGuideContent(GuideContent content, GuideCategory category) {
    mixins.goGuideContent(context, content, category, _categorySet1[0]);
  }

  @override
  void initState() {
    super.initState();
    getGuideCategories();
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: Container(
            padding: EdgeInsets.symmetric(
              vertical: paddings.verticalBase,
              // horizontal: paddings.horizontalBase
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(bottom: 8, left: paddings.horizontalBase),
                  child: SectionLabel(text: '이것만은 꼭 읽고 시작해요'),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 32),
                  child: ScrollSlider(
                      items: _categorySet1,
                      width: 254,
                      height: 320,
                      gap: 12,
                      margin: paddings.horizontalBase,
                      onItemTap: goCategoryDetails),
                ),
                getCategoires(),
              ],
            )));
  }

  Widget getCategoires() {
    return Column(
      children: _categorySet2
          .map((item) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 8, left: paddings.horizontalBase),
                    child: SectionLabel(text: item.title),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 32),
                    child: ScrollSlider(
                        items: item.contents,
                        width: 205,
                        height: 122,
                        gap: 16,
                        margin: paddings.horizontalBase,
                        showLabel: false,
                        showBottomLabel: true,
                        onItemTap: (GuideContent content) {
                          _goGuideContent(content, item);
                        }),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
