import "../common/helper.dart";

class Topic{
  int id;
  String authorName;
  String authorAvatar;
  String title;
  int replyCount;
  String createdAt;
  String nodeName;

  Topic.fromJson(Map json):
    this.id = json['id'],
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

class TopicDetail extends Topic{
  String content;
 
  TopicDetail.fromJson(Map json):
    this.content = json['content'],
    super.fromJson(json);
}

class Reply{
  int id;
  String authorName;
  String authorAvatar;
  String createdAt;
  String content;
  int thanks;

  Reply.fromJson(Map json):
    this.id = json['id'],
    this.authorName = json['member']['username'],
    this.authorAvatar = formatAvatar(json['member']['avatar_normal']),
    this.createdAt = fromNow(json['created']),
    this.thanks =  json['thanks'],
    this.content = json['content'];
}