class Username {
  late String username, email, phone, image, cover, bio;

  Username({
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.cover,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['cover'] = cover;
    map['bio'] = bio;
    return map;
  }

  Username.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    cover = map['cover'];
    bio = map['bio'];
  }
}
