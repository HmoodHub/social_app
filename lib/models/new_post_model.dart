class Post {
  late String id, username, image, dateTime, content, postImage;

  Post({
    required this.id,
    required this.username,
    required this.image,
    required this.content,
    required this.dateTime,
    required this.postImage,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['username'] = username;
    map['image'] = image;
    map['content'] = content;
    map['dateTime'] = dateTime;
    map['postImage'] = postImage;
    return map;
  }

  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    image = map['image'];
    postImage = map['postImage'];
    content = map['content'];
    dateTime = map['dateTime'];
  }
}
