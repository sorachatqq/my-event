import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/models/model_event.dart';
import '../../../utils/state/theme_state.dart';
import 'components/button_home.dart';
import '../../../utils/components/event_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeState themeController = Get.put(ThemeState());
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
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.push(context.namedLocation('profile'));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xffD9D9D9),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          themeController
                              .switchTheme(!themeController.isDarkMode.value);
                        },
                        child: Text(
                          'อีเว้นท์ใกล้ฉัน',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ButtonHome(
                          icons: Icons.filter_alt,
                          borderRadius: 10,
                          bg: Color(0xff797979),
                          shadow: Color.fromARGB(255, 82, 82, 82),
                          text: 'ค้นหาตามหมวดหมู่',
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonHome(
                                icons: Icons.edit_square,
                                borderRadius: 10,
                                bg: Color(0xff27AE4D),
                                shadow: Color.fromARGB(255, 28, 126, 56),
                                text: 'เพิ่มอีเว้นท์',
                                onTap: () {
                                  context.push(context.namedLocation('event',
                                      pathParameters: {"id": 'add'}));
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ButtonHome(
                                icons: Icons.search,
                                borderRadius: 10,
                                bg: Color(0xff274DAE),
                                shadow: Color.fromARGB(255, 29, 58, 130),
                                text: 'ค้นหาใหม่',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int index = 0; index < events.length; index++)
                          EventWidget(
                            event: events[index],
                          ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
