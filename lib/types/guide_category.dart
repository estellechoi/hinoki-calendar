import 'guide_content.dart';

class GuideCategory {
  final int categoryId;
  final List<dynamic> contents;
  final String imagePath;
  final bool isLock;
  final String preparation;
  final String purpose;
  final String summary;
  final String title;
  final String authorizedAt;

  final int id;
  final bool isRead;
  final String? label;

  GuideCategory(
      {required this.categoryId,
      required this.contents,
      required this.imagePath,
      required this.isLock,
      required this.preparation,
      required this.purpose,
      required this.summary,
      required this.title,
      this.authorizedAt = '',
      required this.id,
      this.isRead = false,
      this.label});

  factory GuideCategory.fromJson(Map<String, dynamic> json) {
    List<dynamic> contents =
        json['contents'].map((item) => GuideContent.fromJson(item)).toList();
    contents.sort((a, b) => a.orderNum.compareTo(b.orderNum) as int);

    return GuideCategory(
        categoryId: json['category_id'].toInt(),
        contents: contents,
        imagePath: json['image_path'],
        isLock: json['is_lock'],
        preparation: json['preparation'],
        purpose: json['purpose'],
        summary: json['summary'],
        title: json['title'],
        id: json['category_id'].toInt());
  }
}
