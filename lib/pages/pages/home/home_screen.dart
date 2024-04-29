import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_event_flutter/pages/pages/home/components/select_event.dart';
import 'package:my_event_flutter/utils/state/event_state.dart';
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
  bool _isEventLoading = false;
  final ThemeState themeController = Get.put(ThemeState());
  final LocationState locationController = Get.put(LocationState());
  final EventState eventController = Get.put(EventState());
  String selectedCategory = 'ทั้งหมด';

  @override
  void initState() {
    _isEventLoading = false;
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
    getLocation();
    loadEvent();
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

  Future<void> loadEvent() async {
    setState(() {
      _isEventLoading = true;
    });
    await eventController.load();
    setState(() {
      _isEventLoading = false;
    });
  }

  List<EventWidget> getEvents () {
    return eventController.events.where((element) =>
      (
        selectedCategory != "ทั้งหมด" &&
        element.type == selectedCategory
      ) || selectedCategory == "ทั้งหมด"
    ).map((e) => EventWidget(
      event: e,
      locationController: locationController,
    )).toList();
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
                        // child: ButtonHome(
                        //   icons: Icons.filter_alt,
                        //   borderRadius: 10,
                        //   bg: const Color(0xff797979),
                        //   shadow: const Color.fromARGB(255, 82, 82, 82),
                        //   text: 'ค้นหาตามหมวดหมู่',
                        //   onTap: () {},
                        // ),
                        child: _isEventLoading ? const Text("Loading...") : SelectFilter(
                            hintText: 'ค้นหาตามหมวดหมู่',
                            items: const ["ทั้งหมด"].toList() +
                                (eventController.events
                                    .where(
                                        (element) => element.type != null)
                                    .map((e) => e.type ?? 'Unknown')
                                    .toSet()
                                    .toList()),
                            value: selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value ?? 'ทั้งหมด';
                              });
                              print('selected category: $value');
                            }),
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
                        children: getEvents(),
                    )
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
