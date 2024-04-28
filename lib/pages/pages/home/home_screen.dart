import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_event_flutter/utils/mock/event.dart';
import '../../../utils/models/model_event.dart';
import '../../../utils/state/location_state.dart';
import '../../../utils/state/theme_state.dart';
import 'components/button_home.dart';
import '../../../utils/components/event_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLocationLoading = false;
  final ThemeState themeController = Get.put(ThemeState());
  final LocationState locationController = Get.put(LocationState());
  
  @override
  void initState() {
    _isLocationLoading = false;
    super.initState();
    init();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  init() async {
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
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            themeController
                                .switchTheme(!themeController.isDarkMode.value);
                          },
                          child: const Text(
                            'อีเว้นท์ใกล้ฉัน',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            themeController
                                .switchTheme(!themeController.isDarkMode.value);
                          },
                          child: Obx(
                            () => Text(
                              '${locationController.currentLocation.value.latitude},${locationController.currentLocation.value.longitude}',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ButtonHome(
                          icons: Icons.filter_alt,
                          borderRadius: 10,
                          bg: const Color(0xff797979),
                          shadow: const Color.fromARGB(255, 82, 82, 82),
                          text: 'ค้นหาตามหมวดหมู่',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
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
                                bg: const Color(0xff27AE4D),
                                shadow: const Color.fromARGB(255, 28, 126, 56),
                                text: 'เพิ่มอีเว้นท์',
                                onTap: () {
                                  print('redirecting to: add event page');
                                  context.push(context.namedLocation('event',
                                      pathParameters: {"id": 'add'}));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ButtonHome(
                                icons: Icons.search,
                                borderRadius: 10,
                                bg: const Color(0xff274DAE),
                                shadow: const Color.fromARGB(255, 29, 58, 130),
                                text: 'ค้นหาใหม่',
                                isLoading: _isLocationLoading,
                                onTap: () {
                                  getLocation();
                                },
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
