import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_event_flutter/utils/state/event_state.dart';
import 'package:my_event_flutter/utils/state/location_state.dart';

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
  bool _isLocationLoading = false;
  final ThemeState themeController = Get.put(ThemeState());
  final LocationState locationController = Get.put(LocationState());
  final EventState eventController = Get.put(EventState());

  @override
  void initState() {
    _isLocationLoading = false;
    super.initState();
    init();
  }

  @override
  void dispose() {
    locationController.dispose();
    eventController.dispose();
    super.dispose();
  }

  init() async {
    await eventController.load();
    getLocation();
  }

  Future<void> getLocation() async {
    setState(() {
      _isLocationLoading = true;
    });
    await locationController.load();
    setState(() {
      _isLocationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLocationLoading == true) return const Center(child: CircularProgressIndicator());
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
                          margin: const EdgeInsets.only(right: 16),
                          child: const CircleAvatar(
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
                        child: const Text(
                          'อีเว้นท์ที่ฉันสร้าง',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,)
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
                        
                        const Row(
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
                            index < eventController.events.length;
                            index++)
                            if (eventController.events[index].approved != true)
                          EventWidget(
                            event: eventController.events[index],
                            locationController: locationController,
                          ),
                        const Row(
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
                            index < eventController.events.length;
                            index++)
                            if (eventController.events[index].approved == true)
                          EventWidget(
                            event: eventController.events[index],
                            locationController: locationController,
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
