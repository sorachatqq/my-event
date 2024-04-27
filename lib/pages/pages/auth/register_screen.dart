import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/models/model_user.dart';
import '../../../utils/state/auth_state.dart';
import 'components/button_login.dart';
import 'components/select_login.dart';
import 'components/text_field_login.dart';
import '../../../utils/state/theme_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();
  int activeStep = 0;

  Future<void> register() async {
    print('สมัครสมาชิก');
    try {
      // Map obj = {
      //   "username": usernameController.text.trim(),
      //   "email": emailController.text.trim(),
      //   "password": passwordController.text.trim(),
      //   "cPassword": cPasswordController.text.trim(),
      //   "gender": 1,
      //   "age": 18,
      //   "favorite": 1,
      // };
      // final res = await NativeApiService.post("auth/register", obj);
      // Map data = res;

      UserAuth newUser = UserAuth.fromJson({
        "id": "1",
        "email": "yyy@xxx.com",
        "username": "username",
        "firstname": "สมชาย",
        "lastname": "เข็มกลัด",
        "token": "1",
        "image": "",
      });
      authController.save(newUser);
      context.go(context.namedLocation('home'));
    } catch (err) {
      print(err);
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
                                Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  height: 60,
                                  // color: Colors.red,
                                  child: EasyStepper(
                                    activeStep: activeStep,
                                    // lineLength: 50,
                                    lineStyle: LineStyle(
                                      lineLength: 100,
                                      lineThickness: 3,
                                      lineWidth: 0,
                                      lineType: LineType.normal,
                                      defaultLineColor: Color(0xffD9D9D9),
                                      finishedLineColor: Color(0xff4ECB01),
                                    ),
                                    activeStepBackgroundColor:
                                        Color(0xff4ECB01),
                                    activeStepBorderColor: Color(0xff4ECB01),

                                    // internalPadding: 0,
                                    stepRadius: 20,
                                    borderThickness: 0,

                                    showStepBorder: false,
                                    finishedStepBorderColor: Color(0xff4ECB01),
                                    finishedStepBackgroundColor:
                                        Color(0xff4ECB01),
                                    activeStepIconColor: Color(0xff4ECB01),
                                    showLoadingAnimation: false,
                                    steps: [
                                      EasyStep(
                                        customStep: Text(
                                          '1',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      EasyStep(
                                        customStep: CircleAvatar(
                                          // radius: 8,
                                          backgroundColor: activeStep >= 1
                                              ? Color(0xff4ECB01)
                                              : Color(0xffD9D9D9),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                    onStepReached: (index) =>
                                        setState(() => activeStep = index),
                                  ),
                                ),
                                if (activeStep == 0) ...[
                                  TextFieldLogin(
                                    controller: usernameController,
                                    keyboardType: TextInputType.text,
                                    hintText: 'ชื่อผู้ใช้งาน',
                                    obscureText: false,
                                  ),
                                  TextFieldLogin(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: 'อีเมลล์',
                                    obscureText: false,
                                  ),
                                  TextFieldLogin(
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                    hintText: 'รหัสผ่าน',
                                    obscureText: true,
                                  ),
                                  TextFieldLogin(
                                    controller: cPasswordController,
                                    keyboardType: TextInputType.text,
                                    hintText: 'ยืนยันรหัสผ่านอีกครั้ง',
                                    obscureText: true,
                                  ),
                                ],
                                if (activeStep == 1) ...[
                                  SelectLogin(
                                    hintText: 'เพศ',
                                  ),
                                  SelectLogin(
                                    hintText: 'อายุ',
                                  ),
                                  SelectLogin(
                                    hintText: 'สิ่งที่ชอบ',
                                  ),
                                ],
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: Column(
                                    children: [
                                      ButtonLogin(
                                        bg: Color(0xff27AE4D),
                                        shadow:
                                            Color.fromARGB(255, 28, 126, 56),
                                        text: activeStep == 0
                                            ? 'ต่อไป'
                                            : 'เสร็จสิ้น',
                                        onTap: () {
                                          if (activeStep == 0) {
                                            setState(() {
                                              activeStep = 1;
                                            });
                                            print('ต่อไป');
                                          } else {
                                            print('เสร็จสิ้น');
                                            register();
                                          }
                                        },
                                      ),
                                      ButtonLogin(
                                        bg: Color(0xff274DAE),
                                        shadow:
                                            Color.fromARGB(255, 28, 55, 123),
                                        text: 'ย้อนกลับ',
                                        onTap: () {
                                          context.pop();
                                        },
                                      ),
                                    ],
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
