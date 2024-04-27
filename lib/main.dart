import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/routes.dart';
import 'utils/state/theme_state.dart';
import 'utils/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeState themeController = Get.put(ThemeState());

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeState>(
      builder: (ThemeState controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(context),
            routerConfig: MyRoute.routes,
          ),
        );
      },
    );
  }
}
