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
    String? fullName = prefs.getString('full_name');
    String? token = prefs.getString('token');
    String? image = prefs.getString('image');
    UserAuth loadAuth = UserAuth(
      id: id,
      email: email,
      username: username,
      fullName: fullName,
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
    await prefs.setString('full_name', newUser.fullName.toString());
    await prefs.setString('token', newUser.token.toString());
    await prefs.setString('image', newUser.image.toString());
    user.value = newUser;
  }

  Future<void> edit(UserAuth newUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newUser.email.toString());
    await prefs.setString('full_name', newUser.fullName.toString());
    user.value = UserAuth(
      id: user.value.id,
      email: newUser.email,
      username: user.value.username,
      fullName: newUser.fullName,
      token: user.value.token,
      image: newUser.image,
    );
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('username');
    await prefs.remove('full_name');
    await prefs.remove('token');
    await prefs.remove('image');

    UserAuth loadAuth = UserAuth(
      id: null,
      email: null,
      username: null,
      fullName: null,
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
