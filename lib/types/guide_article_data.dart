class GuideArticleData {
  final String title;
  final String summary;
  final String description;
  final String imagePath;
  final int orderNum;

  GuideArticleData({
    required this.title,
    required this.summary,
    required this.description,
    required this.imagePath,
    required this.orderNum,
  });

  factory GuideArticleData.fromJson(Map<String, dynamic> json) {
    return GuideArticleData(
        title: json['title'],
        summary: json['summary'],
        description: json['description'],
        imagePath: json['image_path'],
        orderNum: json['order_num'].toInt());
  }
}
