class GuideUnreadCnt {
  final int unreadContentCount;

  GuideUnreadCnt({
    required this.unreadContentCount,
  });

  factory GuideUnreadCnt.fromJson(Map<String, dynamic> json) {
    return GuideUnreadCnt(
        unreadContentCount: json['unread_content_count'].toInt());
  }
}
