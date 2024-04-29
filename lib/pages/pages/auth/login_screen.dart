import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/models/model_user.dart';
import '../../../utils/services/native_api_service.dart';
import '../../../utils/state/auth_state.dart';
import 'components/button_login.dart';
import 'components/text_field_login.dart';
import '../../../utils/state/theme_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<void> login() async {
    print('เข้าใช้งาน');
    try {
      dio.FormData obj = dio.FormData.fromMap({
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      });
      final res = await NativeApiService.post("token", obj, formEncoded: true);
      Map data = res;

      print(data);
      UserAuth newUser = UserAuth.fromJson({
        ...data['user'],
        "id": data['user']['_id'],
      });
      authController.save(newUser);
      context.go(context.namedLocation('home'));
    } on dio.DioException catch (err) {
      NativeApiService.alert(context,
        content: (err).response!.data['detail'] ?? 'Something went wrong',
        title: 'Error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: themeController.isDarkMode.value == true
                    ? ExactAssetImage('assets/images/bg/login_dark.png')
                    : ExactAssetImage('assets/images/bg/login_light.png'))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: InkWell(
                onTap: () {
                  themeController
                      .switchTheme(!themeController.isDarkMode.value);
                },
                child: Container(
                  height: 150,
                  child: Center(
                      child: Text(
                    'My Event',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.laila().fontFamily,
                        color: themeController.isDarkMode.value == true
                            ? Color(0xffFF6914)
                            : Color(0xff0FA6E7)),
                  )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                TextFieldLogin(
                                  controller: usernameController,
                                  keyboardType: TextInputType.text,
                                  hintText: 'ชื่อผู้ใช้งาน',
                                  obscureText: false,
                                ),
                                TextFieldLogin(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  hintText: 'รหัสผ่าน',
                                  obscureText: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: Column(
                                    children: [
                                      ButtonLogin(
                                        bg: Color(0xff27AE4D),
                                        shadow:
                                            Color.fromARGB(255, 28, 126, 56),
                                        text: 'เข้าใช้งาน',
                                        onTap: () {
                                          login();
                                        },
                                      ),
                                      ButtonLogin(
                                        bg: Color(0xff27AE4D),
                                        shadow:
                                            Color.fromARGB(255, 28, 126, 56),
                                        text: 'ลงทะเบียน',
                                        onTap: () {
                                          context.push(context
                                              .namedLocation('register'));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'ลืมรหัสผ่าน?',
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                          offset: Offset(0, -2.5))
                                    ],
                                    color: Colors.transparent,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    decorationColor: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    decorationThickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            SafeArea(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'นโยบายแอพพลิเคชั่น',
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inverseSurface,
                                                offset: Offset(0, -2.5))
                                          ],
                                          color: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          decorationColor: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                          decorationThickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'นโยบายความเป็นส่วนตัว',
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inverseSurface,
                                                offset: Offset(0, -2.5))
                                          ],
                                          color: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          decorationColor: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                          decorationThickness: 1,
                                        ),
                                      ),
                                      Text(
                                        'V X.XX.XXXXXX',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
