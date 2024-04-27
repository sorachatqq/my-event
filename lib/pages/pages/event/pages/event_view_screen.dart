import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/state/auth_state.dart';
import '../../../../utils/state/theme_state.dart';
import '../components/button_event.dart';
import '../components/modal_event.dart';

class EventViewScreen extends StatefulWidget {
  const EventViewScreen({super.key, required this.id});
  final String id;

  @override
  State<EventViewScreen> createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());

  Future<void> joining() async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        // backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => ModalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.4), // ปรับค่า opacity เพื่อให้มืดลงตามต้องการ
                  BlendMode.darken, // ใช้ BlendMode เพื่อให้รูปภาพมืดลง
                ),
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
                    'มหกรรมหนังสือ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                            flex: 2,
                            child: ButtonEvent(
                              vertical: 10,
                              borderRadius: 8,
                              bg: Color(0xff797979),
                              shadow: Color.fromARGB(255, 82, 82, 82),
                              text: 'กลับหน้าหลัก',
                              onTap: () {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 20,
                                              height: 20,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Color(0xff27AE4D),
                                              )),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ยืนยันแล้ว',
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'กิจกรรมนี้เชื่อถือได้ ผ่านการยืนยันจากระบบแล้ว',
                                                  maxLines: 3,
                                                  style: TextStyle(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel purus quis enim venenatis iaculis. Pellentesque et sodales massa. Maecenas accumsan velit non lorem porta tristique. Vestibulum bibendum et magna quis eleifend. Vivamus arcu dui, sollicitudin non efficitur eget, porttitor eu dolor. Proin vel euismod ipsum. Morbi vel semper sem. Morbi fermentum at velit eget volutpat Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel purus quis enim venenatis iaculis. Pellentesque et sodales massa. Maecenas accumsan velit non lorem porta tristique. Vestibulum bibendum et magna quis eleifend. Vivamus arcu dui, sollicitudin non efficitur eget, porttitor eu dolor. Proin vel euismod ipsum. Morbi vel semper sem. Morbi fermentum at velit eget volutpat Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel purus quis enim venenatis iaculis. Pellentesque et sodales massa. Maecenas accumsan velit non lorem porta tristique. Vestibulum bibendum et magna quis eleifend. Vivamus arcu dui, sollicitudin non efficitur eget, porttitor eu dolor. Proin vel euismod ipsum. Morbi vel semper sem. Morbi fermentum at velit eget volutpat'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '10.2km',
                                            style: TextStyle(),
                                          ),
                                          Icon(
                                            Icons.pin_drop,
                                            size: 15,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'อิมแพคอารีนา เมืองทองธานี',
                                            style: TextStyle(),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '17 มกราคม 2567 12:00น.',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SafeArea(
                        top: false,
                        bottom: true,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonEvent(
                                    vertical: 15,
                                    borderRadius: 15,
                                    color: Colors.black,
                                    bg: Color(0xffF0F0F0),
                                    shadow: Color.fromARGB(255, 171, 171, 171),
                                    text: 'เปิดแผนที่',
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ButtonEvent(
                                    vertical: 15,
                                    icon: Icons.message,
                                    borderRadius: 15,
                                    color: Colors.white,
                                    bg: Color(0xff274DAE),
                                    shadow: Color.fromARGB(255, 29, 58, 130),
                                    text: '',
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: ButtonEvent(
                                    vertical: 15,
                                    borderRadius: 15,
                                    color: Colors.white,
                                    bg: Color(0xff27AE4D),
                                    shadow: Color.fromARGB(255, 28, 126, 56),
                                    text: 'ฉันสนใจจะเข้าร่วม',
                                    onTap: () {
                                      joining();
                                    },
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
            )
          ],
        ),
      ),
    );
  }
}
