// generate update profile screen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_event_flutter/pages/pages/profile/components/button_profile.dart';
import 'package:my_event_flutter/utils/models/model_user.dart';
import 'package:my_event_flutter/utils/state/auth_state.dart';
import 'package:my_event_flutter/utils/state/location_state.dart';
import 'package:my_event_flutter/utils/state/theme_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());
  UserAuth user = UserAuth();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    authController.dispose();
    super.dispose();
  }

  init() async {
    await authController.load();
    setState(() {
      user = authController.user.value;
    });
  }

  updateUser (String field, String value) {
    Map<String, dynamic> json = {
      ...user.toJson(),
      field: value,
    };
    UserAuth newUser = UserAuth.fromJson(json);
    authController.save(newUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push(context.namedLocation('profile'));
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'แก้ไขโปรไฟล์',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('ชื่อจริง'),
                  TextField(
                    controller: TextEditingController(
                        text: authController.user.value.firstname),
                    onChanged: (value) {
                      updateUser("firstname", value);
                    },
                  ),
                  const Text('นามสกุล'),
                  TextField(
                    controller: TextEditingController(
                        text: authController.user.value.lastname),
                    onChanged: (value) {
                      updateUser("lastname", value);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Username'),
                  TextField(
                    controller: TextEditingController(
                        text: authController.user.value.username),
                    onChanged: (value) {
                      updateUser("username", value);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Email'),
                  TextField(
                    controller: TextEditingController(
                        text: authController.user.value.email),
                    onChanged: (value) {
                      updateUser("email", value);
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonProfile(
                    borderRadius: 15,
                    bg: const Color(0xff27AE4D),
                    shadow: const Color.fromARGB(255, 28, 126, 56),
                    text: 'บันทึก',
                    onTap: () {
                      authController.load();
                      print(authController.user.value.toJson());
                      context.push(context.namedLocation('profile'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
