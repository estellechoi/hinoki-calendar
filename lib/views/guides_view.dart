import 'package:flutter/material.dart';
import 'package:flutter_app/types/guide_category.dart';
import 'index.dart';
import '../widgets/buttons/f_button.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/modals/guide_notify.dart';

// getGuideCategories

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

      appState.unreadCnt = record.unreadContentCount;

      setState(() {
        _categorySet1 =
            record.categories.where((item) => item.categoryId < 3).map((item) {
          // item['label'] = '${item.contents.length}개의 가이드 / 초보자 필독';
          // return item;
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

  void goArticle() {
    appState.pushNavigation(fetchGuideArticlePageConfig('25'));
  }

  void goCategoryDetails(int id) {
    print('goCategoryDetails');
    print(id);
    appState.pushNavigation(fetchGuideCategoryPageConfig(id.toString()));
  }

  void _goGuideContent(int id) {
    print('_goGuideContent');
    print(id);
    // ...
    final RoundedRectangleBorder modalShape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));
    final RoundedRectangleBorder modalSubShape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));

    showMaterialModalBottomSheet(
        context: context,
        useRootNavigator: true,
        shape: ShapeBorder.lerp(modalShape, modalSubShape, 0),
        clipBehavior: Clip.hardEdge,
        duration: const Duration(milliseconds: 600),
        builder: (context) {
          return GuideNotify(
              title: '키토제닉 꿀팁',
              description:
                  '몸이 키토제닉 식단에 적응하고 안정기에 접어들 때 팁을 확인해야 목표달성 확률을 높일 수 있어요.',
              buttonLabel: '이전 꿀팁을 먼저 읽어보세요',
              showRecommendation: true,
              recommendTitle: '순탄수화물 쉽게 계산하기',
              recommendImagePath: 'https://picsum.photos/250?image=9',
              showSummary: false,
              summary: '');
        });
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
                FButton(type: 'blue', onPressed: goArticle, text: '테스트')
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
                        onItemTap: _goGuideContent),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
