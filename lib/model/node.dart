class Node{
  int id;
  String name;
  int createdAt;

  Node.fromJson(Map json):
    this.id = json['id'], 
    this.name = json['name'], 
    this.createdAt = json['created'];
}