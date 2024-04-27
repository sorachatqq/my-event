class UserAuth {
  final String? id;
  final String? email;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? token;
  final String? image;

  UserAuth({
    this.id,
    this.email,
    this.username,
    this.firstname,
    this.lastname,
    this.token,
    this.image,
  });

  factory UserAuth.fromJson(Map json) {
    Map item = json;

    return UserAuth(
      id: item['id'],
      email: item['email'],
      username: item['username'],
      firstname: item['firstname'],
      lastname: item['lastname'],
      token: item['token'],
      image: item['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "token": token,
        "image": image,
      };
}
