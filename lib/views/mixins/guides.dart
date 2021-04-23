import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../widgets/modals/guide_notify.dart';
import '../../app_state.dart';
import '../../route/pages.dart';
import '../../types/guide_content.dart';
import '../../types/guide_category.dart';
import '../../utils/format.dart' as format;

const int GUIDE_CATE_HONEYTIP = 4;

void goGuideContent(BuildContext context, GuideContent content,
    GuideCategory category, GuideCategory essentialCategory) {
  print('goGuideContent');

  // 꿀팁 X
  if (category.id != GUIDE_CATE_HONEYTIP) {
    if (content.isLock == false) goArticle(content.id);
    return;
  }

  // 꿀팁 체크 1 : 입문 가이드 완료 여부
  final bool unreadEssential =
      essentialCategory.contents.any((item) => item.isRead == false);

  if (unreadEssential == true) {
    showBottomModal(context, category.title, '입문 가이드를 먼저 읽어보세요', true,
        '오픈 조건 : 입문가이드 모두 읽기', false, '', '');
    return;
  }

  // 꿀팁 체크 2 : 읽지 않은 꿀팁 존재 여부
  final List<dynamic> unreadHoneyTips = category.contents
      .where((item) => item.orderNum < content.orderNum && item.isRead == false)
      .toList();

  if (unreadHoneyTips.length > 0) {
    GuideContent recomm = unreadHoneyTips[0];
    showBottomModal(context, category.title, '이전 꿀팁을 먼저 읽어보세요', false, '', true,
        recomm.title, 'https://picsum.photos/250?image=9');
    return;
  }

  // 꿀팁 체크 3 : 열림 여부
  if (content.isLock == true) {
    showBottomModal(
        context,
        category.title,
        '${format.getLeftHHMM(content.authorizedAt)} 후 오픈됩니다',
        false,
        '',
        true,
        content.title,
        'https://picsum.photos/250?image=9');
    return;
  }

  goArticle(content.id);
}

void showBottomModal(
    BuildContext context,
    String title,
    String buttonLabel,
    bool showSummary,
    String summary,
    bool showRecommendation,
    String recommendTitle,
    String recommendImagePath) {
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
            title: title,
            description:
                '몸이 키토제닉 식단에 적응하고 안정기에 접어들 때 팁을 확인해야 목표달성 확률을 높일 수 있어요.',
            buttonLabel: buttonLabel,
            showRecommendation: showRecommendation,
            recommendTitle: recommendTitle,
            recommendImagePath: recommendImagePath,
            showSummary: showSummary,
            summary: summary);
      });
}

void goArticle(int id) {
  appState.pushNavigation(fetchGuideArticlePageConfig(id.toString()));
}
