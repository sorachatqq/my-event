import 'dart:io';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_event_flutter/utils/state/location_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/state/theme_state.dart';
import '../components/button_event.dart';
import '../components/select_event.dart';
import '../components/text_area_event.dart';
import '../components/text_field_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.id});
  final String id;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ImagePicker picker = ImagePicker();
  final ThemeState themeController = Get.put(ThemeState());
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  final LocationState locationController = Get.put(LocationState());
  late final MapController _mapController;
  File? _selectedImage;
  bool _isPageLoading = false;

  String? _selectedGender;
  String? _selectedAgeFrom;
  String? _selectedAgeTo;
  String? _selectedType;
  int activeStep = 0;

  @override
  void initState() {
    _selectedImage = null;
    _isPageLoading = true;
    super.initState();
    init();
  }

  @override
  void dispose() {
    _mapController.dispose();
    locationController.dispose();
    super.dispose();
  }

  init() async {
    getLocation();
    _mapController = MapController();
  }

  Future<void> getLocation() async {
    setState(() {
      _isPageLoading = true;
    });
    await locationController.load();
    setState(() {
      _isPageLoading = false;
    });
  }

  void onMapEvent(MapEvent mapEvent) {
    if (_isPageLoading == false) return;
    debugPrint(mapEvent.source.toString());
    // debugPrint(mapEvent.zoom.toString());

    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      // debugPrint(mapEvent.center.latitude.toString());
      // debugPrint(mapEvent.center.longitude.toString());
    }
    if (mapEvent is MapEventMove) {
      print(mapEvent.camera.center.latitude.toString());
      print(mapEvent.camera.center.longitude.toString());
    }
  }

  void pickAnImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _selectedImage = File(image.path);
    });
  }

  void createEvent() async {
    // push to profile screen
    setState(() {
      _isPageLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    context.push(context.namedLocation('event-created'));
    setState(() {
      _isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isPageLoading == true) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SafeArea(
                  top: true,
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
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
                              '${widget.id == 'add' ? 'เพิ่ม' : 'แก้ไข'}อีเว้นท์',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ButtonEvent(
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
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: EasyStepper(
                    activeStep: activeStep,
                    lineStyle: const LineStyle(
                      lineLength: 90,
                      lineThickness: 3,
                      lineWidth: 0,
                      lineType: LineType.normal,
                      defaultLineColor: Color(0xffD9D9D9),
                      finishedLineColor: Color(0xff4ECB01),
                    ),
                    activeStepBackgroundColor: const Color(0xff4ECB01),
                    activeStepBorderColor: const Color(0xff4ECB01),

                    // internalPadding: 0,
                    stepRadius: 20,
                    borderThickness: 0,

                    showStepBorder: false,
                    finishedStepBorderColor: const Color(0xff4ECB01),
                    finishedStepBackgroundColor: const Color(0xff4ECB01),
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
                      ),
                      EasyStep(
                        enabled: false,
                        customStep: CircleAvatar(
                          // radius: 8,
                          backgroundColor: activeStep >= 2
                              ? const Color(0xff4ECB01)
                              : const Color(0xffD9D9D9),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
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
                        if (activeStep == 0)
                          Column(
                            children: [
                              _selectedImage == null
                                  ? InkWell(
                                      onTap: pickAnImage,
                                      child: Container(
                                        height: 200,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffEDEDED),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_outlined,
                                                size: 60,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Choose a file or drag it here',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  : Image.file(_selectedImage ?? File('')),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'รายละเอียด',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              TextFieldEvent(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                hintText: 'ชื่ออีเว้นท์',
                                obscureText: false,
                              ),
                              TextAreaEvent(
                                controller: detailController,
                                keyboardType: TextInputType.text,
                                hintText: 'คำอธิบายอีเว้นท์อีเว้นท์',
                                obscureText: false,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'สถานที่',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      // color: Color(0xffEDEDED),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      child: FlutterMap(
                                        mapController: _mapController,
                                        options: MapOptions(
                                          onMapReady: () {
                                            _mapController.move(
                                                LatLng(
                                                    locationController
                                                        .currentLocation
                                                        .value
                                                        .latitude,
                                                    locationController
                                                        .currentLocation
                                                        .value
                                                        .longitude),
                                                14);
                                          },
                                          onMapEvent: onMapEvent,
                                          initialCenter: const LatLng(0, 0),
                                          initialZoom: 14,
                                          maxZoom: 18,
                                          minZoom: 2,
                                        ),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'dev.fleaflet.flutter_map.example',
                                          ),
                                          const MarkerLayer(
                                            markers: [],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              'https://www.openstreetmap.org/copyright'));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2, horizontal: 6),
                                              child: Text.rich(
                                                TextSpan(
                                                  text: '© ',
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'OpenStreetMap ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    TextSpan(
                                                        text: 'contributors',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        if (activeStep == 1)
                          Column(
                            children: [
                              Row(children: [
                                Expanded(
                                    child: SelectEvent(
                                  hintText: 'จำกัดเพศ',
                                  items: const ["ชาย", "หญิง", "ไม่จำกัด"],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ))
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: const Text('ตั้งแต่')),
                                  Expanded(
                                    flex: 2,
                                    child: SelectEvent(
                                      hintText: 'อายุ',
                                      items: const ["0", "6", "12", "18", "20"],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedAgeFrom = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 8, left: 8),
                                      child: const Text('ถึง')),
                                  Expanded(
                                    flex: 2,
                                    child: SelectEvent(
                                      hintText: 'อายุ',
                                      items: const ["20", "60", "100"],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedAgeTo = value;
                                        });
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
                                      child: SelectEvent(
                                    hintText: 'ประเภทของอีเว้นท์',
                                    items: const ["ชาย", "หญิง", "ไม่จำกัด"],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType = value;
                                      });
                                    },
                                  )),
                                ],
                              )
                            ],
                          ),
                        SafeArea(
                          top: false,
                          bottom: true,
                          child: Column(
                            children: [
                              if (activeStep >= 1) ...[
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Note: หลังจากยืนยันแล้ว กรุณารอให้ผู้ดูแลยืนยันอีเว้นท์ของคุณ'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                              ButtonEvent(
                                borderRadius: 8,
                                bg: const Color(0xff27AE4D),
                                shadow: const Color.fromARGB(255, 28, 126, 56),
                                text: activeStep == 0 ? 'ต่อไป' : 'เสร็จสิ้น',
                                onTap: () {
                                  if (activeStep >= 1) {
                                    createEvent();
                                    return;
                                  }
                                  setState(() {
                                    activeStep = 1;
                                  });
                                },
                              ),
                              if (activeStep >= 1) ...[
                                const SizedBox(
                                  height: 10,
                                ),
                                ButtonEvent(
                                  borderRadius: 8,
                                  bg: const Color(0xff274DAE),
                                  shadow:
                                      const Color.fromARGB(255, 28, 55, 123),
                                  text: 'ย้อนกลับ',
                                  onTap: () {
                                    setState(() {
                                      activeStep = 0;
                                    });
                                  },
                                ),
                              ],
                            ],
                          ),
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
