import "../common/helper.dart";

class Topic{
  String authorName;
  String authorAvatar;
  String title;
  int replyCount;
  String createdAt;
  String nodeName;

  Topic.fromJson(Map json):
    this.authorName = json['member']['username'],
    this.authorAvatar = formatAvatar(json['member']['avatar_normal']),
    this.title = json['title'],
    this.replyCount = json['replies'],
    this.createdAt = fromNow(json['created']),
    this.nodeName = json['node']['title'];

}

String formatAvatar(String uri) {
  return uri.startsWith('//') ? 'http:$uri' : uri;
}