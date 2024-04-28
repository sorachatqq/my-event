import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_event_flutter/utils/mock/event.dart';
import 'package:my_event_flutter/utils/models/model_event.dart';
import 'package:my_event_flutter/utils/state/location_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/state/auth_state.dart';
import '../../../../utils/state/theme_state.dart';
import '../components/button_event.dart';
import '../components/modal_event.dart';

Type nonNullableTypeOf<T>(T? object) => T;
class EventViewScreen extends StatefulWidget {
  const EventViewScreen({super.key, required this.id});
  final String id;

  @override
  State<EventViewScreen> createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  final ThemeState themeController = Get.put(ThemeState());
  final AuthState authController = Get.put(AuthState());
  final LocationState locationController = Get.put(LocationState());
  bool _isPageLoading = true;
  double lat = 13.9166;
  double lng = 100.5215;

  @override
  void initState() {
    _isPageLoading = true;
    _event = EventModel();
    _isEventFound = false;
    super.initState();
    print('EventViewScreen: ${widget.id}');
    getEventInfo();
  }

  bool _isEventFound = false;
  EventModel _event = EventModel();
  Future<void> getEventInfo() async {
    // Get event info from API
    setState(() {
      _isPageLoading = true;
    });

    await locationController.load();
    setState(() {
      _isEventFound = true;
      _event = events.where((element) => (element.id ?? "1") == (widget.id)).first;
    });

    setState(() {
      _isPageLoading = false;
    });
  }

  double getDistance(LatLng location){
    var loc2 = locationController.currentLocation.value;
    var p = 0.017453292519943295;
    var c = cos;
    var lat2 = location.latitude;
    var lon2 = location.longitude;
    var lat1 = loc2.latitude;
    var lon1 = loc2.longitude;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> joining() async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        // backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => ModalEvent(
          lat: lat,
          lng: lng,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (_isPageLoading == true) return const Center(child: CircularProgressIndicator());
    if (_isEventFound == false) return const Center(child: Text('Event not found'));
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
                    ? const ExactAssetImage('assets/images/bg/login_dark.png')
                    : const ExactAssetImage('assets/images/bg/login_light.png'))),
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
                      _event.name ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    )
                  ),
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
                      const SizedBox(
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
                              bg: const Color(0xff797979),
                              shadow: const Color.fromARGB(255, 82, 82, 82),
                              text: 'กลับหน้าหลัก',
                              onTap: () {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                      if (_event.verify) Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            margin:
                                                const EdgeInsets.only(right: 10),
                                            child: const Icon(
                                              Icons.check_circle,
                                              color: Color(0xff27AE4D),
                                            )
                                          ),
                                          const Flexible(
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
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        _event.detail ?? ''
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${getDistance(_event.location ?? const LatLng(0, 0)).toPrecision(2)}km',
                                            style: const TextStyle(),
                                          ),
                                          const Icon(
                                            Icons.pin_drop,
                                            size: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _event.locationName ?? 'Unknown',
                                              style: const TextStyle(),
                                            )
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            _event.getStartedAt(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
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
                      const SizedBox(
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
                                    bg: const Color(0xffF0F0F0),
                                    shadow: const Color.fromARGB(255, 171, 171, 171),
                                    text: 'เปิดแผนที่',
                                    onTap: () {
                                      launchUrl(
                                          Uri(
                                            scheme: 'https',
                                            host: 'www.google.com',
                                            path: 'maps/search/',
                                            queryParameters: {
                                              'api': '1',
                                              'query': [lat, lng].join(','),
                                            },
                                          )
                                      );
                                    },
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
                                  flex: 1,
                                  child: ButtonEvent(
                                    vertical: 15,
                                    icon: Icons.message,
                                    borderRadius: 15,
                                    color: Colors.white,
                                    bg: const Color(0xff274DAE),
                                    shadow: const Color.fromARGB(255, 29, 58, 130),
                                    text: '',
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: ButtonEvent(
                                    vertical: 15,
                                    borderRadius: 15,
                                    color: Colors.white,
                                    bg: const Color(0xff27AE4D),
                                    shadow: const Color.fromARGB(255, 28, 126, 56),
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
