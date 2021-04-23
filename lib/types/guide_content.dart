class GuideContent {
  final int contentId;
  final bool contentIsLock;
  final bool contentIsRead;
  final String contentSummary;
  final String contentTitle;
  final String imagePath;
  final int orderNum;
  final String authorizedAt;

  // for component use
  final int id;
  final String title;
  final bool isLock;
  final bool isRead;

  String? label;

  GuideContent(
      {required this.contentId,
      required this.contentIsLock,
      required this.contentIsRead,
      required this.contentSummary,
      required this.contentTitle,
      required this.imagePath,
      required this.orderNum,
      required this.authorizedAt,
      required this.id,
      required this.title,
      required this.isLock,
      required this.isRead});

  factory GuideContent.fromJson(Map<String, dynamic> json) {
    return GuideContent(
        contentId: json['content_id'].toInt(),
        contentIsLock: json['content_is_lock'],
        contentIsRead: json['content_is_read'],
        contentSummary: json['content_summary'],
        contentTitle: json['content_title'],
        // imagePath: json['image_path'],
        imagePath: 'https://picsum.photos/250?image=9',
        orderNum: json['order_num'].toInt(),
        authorizedAt: json['authorized_at'] ?? '',
        id: json['content_id'].toInt(),
        title: json['content_title'],
        isLock: json['content_is_lock'],
        isRead: json['content_is_read']);
  }
}
