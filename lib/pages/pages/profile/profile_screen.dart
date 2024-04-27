import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/components/event_widget.dart';
import '../../../utils/models/model_event.dart';
import '../../../utils/state/auth_state.dart';
import '../../../utils/state/theme_state.dart';
import 'components/button_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());
  List<EventModel> events = [
    EventModel(
        id: "1",
        name: 'งานมหกรรมหนังสือ',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: true,
        booking: true),
    EventModel(
        id: "2",
        name: 'งานดนตรี ครั้งที่ 999',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
    EventModel(
        id: "3",
        name: 'Motor Show',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
    EventModel(
        id: "4",
        name: 'Thailand Game Show',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
    EventModel(
        id: "5",
        name: 'Apple WWDC24',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
    EventModel(
        id: "6",
        name: 'FinTech X 88Sandbox',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
    EventModel(
        id: "7",
        name: 'Food Festival',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              themeController.switchTheme(
                                  !themeController.isDarkMode.value);
                            },
                            child: Text(
                              'โปรไฟล์',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ButtonProfile(
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xffD9D9D9),
                      child: Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${authController.user.value.firstname} ${authController.user.value.lastname}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@${authController.user.value.username}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonProfile(
                  borderRadius: 15,
                  bg: Color(0xff27AE4D),
                  shadow: Color.fromARGB(255, 28, 126, 56),
                  text: 'แก้ไขโปรไฟล์',
                  onTap: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ButtonProfile(
                        borderRadius: 15,
                        bg: Color(0xff274DAE),
                        shadow: Color.fromARGB(255, 29, 58, 130),
                        text: 'อีเว้นท์ที่ฉันสร้าง',
                        onTap: () {

                          context.push(context.namedLocation('event-created'));

                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: ButtonProfile(
                        borderRadius: 15,
                        bg: Color(0xffEE675C),
                        shadow: Color.fromARGB(255, 180, 79, 70),
                        text: 'ออกจากระบบ',
                        onTap: () {
                          authController.remove();
                          context.go(context.namedLocation('login'));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'อีเว้นท์ที่เข้าร่วม',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        for (int index = 0; index < events.length; index++)
                          EventWidget(
                            event: events[index],
                            color: Colors.black,
                          ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
