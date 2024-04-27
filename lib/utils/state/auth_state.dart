import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_user.dart';

class AuthState extends GetxController {
  final user = UserAuth().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? email = prefs.getString('email');
    String? username = prefs.getString('username');
    String? firstname = prefs.getString('firstname');
    String? lastname = prefs.getString('lastname');
    String? token = prefs.getString('token');
    String? image = prefs.getString('image');
    UserAuth loadAuth = UserAuth(
      id: id,
      email: email,
      username: username,
      firstname: firstname,
      lastname: lastname,
      token: token,
      image: image,
    );
    user.value = loadAuth;
  }

  Future<void> save(UserAuth newUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', newUser.id.toString());
    await prefs.setString('email', newUser.email.toString());
    await prefs.setString('username', newUser.username.toString());
    await prefs.setString('firstname', newUser.firstname.toString());
    await prefs.setString('lastname', newUser.lastname.toString());
    await prefs.setString('token', newUser.token.toString());
    await prefs.setString('image', newUser.image.toString());
    user.value = newUser;
  }

  Future<void> edit(UserAuth newUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newUser.email.toString());
    await prefs.setString('firstname', newUser.firstname.toString());
    await prefs.setString('lastname', newUser.lastname.toString());
    user.value = UserAuth(
      id: user.value.id,
      email: newUser.email,
      username: user.value.username,
      firstname: newUser.firstname,
      lastname: newUser.lastname,
      token: user.value.token,
      image: newUser.image,
    );
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('username');
    await prefs.remove('firstname');
    await prefs.remove('lastname');
    await prefs.remove('token');
    await prefs.remove('image');

    UserAuth loadAuth = UserAuth(
      id: null,
      email: null,
      username: null,
      firstname: null,
      lastname: null,
      token: null,
      image: null,
    );
    user.value = loadAuth;
  }

  bool isAuthenticated() {
    // ignore: unnecessary_null_comparison
    return user.value.token != null ? true : false;
  }
}
