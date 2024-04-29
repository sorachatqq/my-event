import 'package:dio/dio.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_event_flutter/utils/services/native_api_service.dart';

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
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController interestingController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  int activeStep = 0;
  String gender = 'ชาย';
  int age = 18;

  Future<void> register() async {
    print('สมัครสมาชิก');
    try {
      Map obj = {
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "repeat_password": cPasswordController.text.trim(),
        "full_name": usernameController.text.trim(),
        "gender": gender,
        "age": age,
        "interest_thing": interestingController.text.trim(),
      };
      final res = await NativeApiService.post("signup", obj);
      Map data = res;
      print(data);

      UserAuth newUser = UserAuth.fromJson({
        ...data,
        "id": data['_id'],
      });
      authController.save(newUser);
      context.go(context.namedLocation('login'));
    } catch (err) {
      print(err);
      NativeApiService.alert(context,
        content: (err as DioException).response!.data['detail'] ?? 'Something went wrong',
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
                    ? const ExactAssetImage('assets/images/bg/login_dark.png')
                    : const ExactAssetImage(
                        'assets/images/bg/login_light.png'))),
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
                            ? const Color(0xffFF6914)
                            : const Color(0xff0FA6E7)),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              height: 60,
                              // color: Colors.red,
                              child: EasyStepper(
                                activeStep: activeStep,
                                // lineLength: 50,
                                lineStyle: const LineStyle(
                                  lineLength: 100,
                                  lineThickness: 3,
                                  lineWidth: 0,
                                  lineType: LineType.normal,
                                  defaultLineColor: Color(0xffD9D9D9),
                                  finishedLineColor: Color(0xff4ECB01),
                                ),
                                activeStepBackgroundColor:
                                    const Color(0xff4ECB01),
                                activeStepBorderColor: const Color(0xff4ECB01),

                                // internalPadding: 0,
                                stepRadius: 20,
                                borderThickness: 0,

                                showStepBorder: false,
                                finishedStepBorderColor:
                                    const Color(0xff4ECB01),
                                finishedStepBackgroundColor:
                                    const Color(0xff4ECB01),
                                activeStepIconColor: const Color(0xff4ECB01),
                                showLoadingAnimation: false,
                                steps: [
                                  const EasyStep(
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
                                          ? const Color(0xff4ECB01)
                                          : const Color(0xffD9D9D9),
                                      child: const Text(
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
                            if (activeStep == 0)
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                  ]),
                            if (activeStep == 1)
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SelectLogin(
                                      hintText: 'เพศ',
                                      items: const ['ชาย', 'หญิง'],
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                      value: gender,
                                    ),
                                    TextFieldLogin(
                                      controller: ageController,
                                      keyboardType: TextInputType.number,
                                      hintText: 'อายุ',
                                      obscureText: false,
                                    ),
                                    TextFieldLogin(
                                      controller: interestingController,
                                      keyboardType: TextInputType.text,
                                      hintText: 'สิ่งที่ชอบ',
                                      obscureText: false,
                                    ),
                                  ]),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: Column(
                                    children: [
                                      ButtonLogin(
                                        bg: const Color(0xff27AE4D),
                                        shadow: const Color.fromARGB(
                                            255, 28, 126, 56),
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
                                        bg: const Color(0xff274DAE),
                                        shadow: const Color.fromARGB(
                                            255, 28, 55, 123),
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
                                                offset: const Offset(0, -2.5))
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
                                      const Text(
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
