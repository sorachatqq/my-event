import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/components/event_widget.dart';
import '../../../../utils/models/model_event.dart';
import '../../../../utils/state/theme_state.dart';
import '../../home/components/button_home.dart';

class EventCreatedScreen extends StatefulWidget {
  const EventCreatedScreen({super.key});

  @override
  State<EventCreatedScreen> createState() => _EventCreatedScreenState();
}

class _EventCreatedScreenState extends State<EventCreatedScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  List<EventModel> waitingEvents = [
    EventModel(
        id: "1",
        name: 'งานมหกรรมหนังสือ',
        detail:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum luctus erat vel velit euismod dictum.',
        verify: false,
        booking: false),
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
  ];
  List<EventModel> pendingEvents = [
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
  ];
  List<EventModel> successEvents = [
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
              bottom: false,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
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
                          'อีเว้นท์ที่ฉันสร้าง',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,)
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'รอการยืนยัน',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: ButtonHome(
                                icons: Icons.filter_alt,
                                borderRadius: 10,
                                bg: Color(0xff797979),
                                shadow: Color.fromARGB(255, 82, 82, 82),
                                fontSize: 16,
                                text: 'ตัวกรอง',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        for (int index = 0;
                            index < waitingEvents.length;
                            index++)
                          EventWidget(
                            event: waitingEvents[index],
                          ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'กำลังดำเนินการ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        for (int index = 0;
                            index < pendingEvents.length;
                            index++)
                          EventWidget(
                            event: pendingEvents[index],
                          ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        for (int index = 0;
                            index < successEvents.length;
                            index++)
                          EventWidget(
                            event: successEvents[index],
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
