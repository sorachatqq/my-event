class UserAuth {
  final String? id;
  final String? email;
  final String? username;
  final String? fullName;
  final String? token;
  final String? image;
  final String? role;

  UserAuth({
    this.id,
    this.email,
    this.username,
    this.fullName,
    this.token,
    this.image,
    this.role,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    Map item = json;

    return UserAuth(
      id: item['id'],
      email: item['email'],
      username: item['username'],
      fullName: item['full_name'],
      token: item['token'],
      image: item['image'],
      role: item['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "full_name": fullName,
        "token": token,
        "image": image,
        "role": role,
      };
}
