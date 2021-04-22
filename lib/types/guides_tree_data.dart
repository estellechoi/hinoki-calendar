import 'guide_category.dart';

class GuidesTreeData {
  final int unreadContentCount;
  final List<dynamic> categories;

  GuidesTreeData({required this.unreadContentCount, required this.categories});

  factory GuidesTreeData.fromJson(Map<String, dynamic> json) {
    return GuidesTreeData(
        unreadContentCount: json['unread_content_count'].toInt(),
        categories: json['categories']
            .map((item) => GuideCategory.fromJson(item))
            .toList());
  }
}
