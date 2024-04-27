import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState extends GetxController {
  final isDarkMode = false.obs;

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
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      switchTheme(isDark);
    } else {
      isDarkMode.value = false;
    }
  }

  Future<void> switchTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = value;
    prefs.setBool('isDark', value);
  }
}
