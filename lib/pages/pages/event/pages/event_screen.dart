import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
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
  final ThemeState themeController = Get.put(ThemeState());
  TextEditingController nameController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  late final MapController _mapController;

  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _mapController = MapController();
  }

  void onMapEvent(MapEvent mapEvent) {
    debugPrint(mapEvent.source.toString());
    // debugPrint(mapEvent.zoom.toString());

    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      // debugPrint(mapEvent.center.latitude.toString());
      // debugPrint(mapEvent.center.longitude.toString());
    }
  }

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
                  top: true,
                  bottom: false,
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
                              '${widget.id == 'add' ? 'เพิ่ม' : 'แก้ไข'}อีเว้นท์',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ButtonEvent(
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
                Container(
                  height: 60,
                  child: EasyStepper(
                    activeStep: activeStep,
                    lineStyle: LineStyle(
                      lineLength: 90,
                      lineThickness: 3,
                      lineWidth: 0,
                      lineType: LineType.normal,
                      defaultLineColor: Color(0xffD9D9D9),
                      finishedLineColor: Color(0xff4ECB01),
                    ),
                    activeStepBackgroundColor: Color(0xff4ECB01),
                    activeStepBorderColor: Color(0xff4ECB01),

                    // internalPadding: 0,
                    stepRadius: 20,
                    borderThickness: 0,

                    showStepBorder: false,
                    finishedStepBorderColor: Color(0xff4ECB01),
                    finishedStepBackgroundColor: Color(0xff4ECB01),
                    activeStepIconColor: Color(0xff4ECB01),
                    showLoadingAnimation: false,
                    steps: [
                      EasyStep(
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
                              ? Color(0xff4ECB01)
                              : Color(0xffD9D9D9),
                          child: Text(
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
                              ? Color(0xff4ECB01)
                              : Color(0xffD9D9D9),
                          child: Icon(
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
                SizedBox(
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
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffEDEDED),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
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
                              Row(
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
                                    decoration: BoxDecoration(
                                      // color: Color(0xffEDEDED),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      child: FlutterMap(
                                        mapController: _mapController,
                                        options: MapOptions(
                                          onMapEvent: onMapEvent,
                                          initialCenter: const LatLng(
                                              16.184007780288713,
                                              103.30415368080139),
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
                                          MarkerLayer(
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
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                            ),
                                            child: Padding(
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
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        if (activeStep == 1)
                          Column(
                            children: [
                              SelectEvent(
                                hintText: 'จำกัดเพศ',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Text('ตั้งแต่')),
                                  Expanded(
                                    flex: 2,
                                    child: SelectEvent(
                                      hintText: 'อายุ',
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(right: 8, left: 8),
                                      child: Text('ถึง')),
                                  Expanded(
                                    flex: 2,
                                    child: SelectEvent(
                                      hintText: 'อายุ',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SelectEvent(
                                hintText: 'ประเภทของอีเว้นท์',
                              ),
                            ],
                          ),
                        SafeArea(
                          top: false,
                          bottom: true,
                          child: Column(
                            children: [
                              if (activeStep >= 1) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Note: หลังจากยืนยันแล้ว กรุณารอให้ผู้ดูแลยืนยันอีเว้นท์ของคุณ'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                              ButtonEvent(
                                borderRadius: 8,
                                bg: Color(0xff27AE4D),
                                shadow: Color.fromARGB(255, 28, 126, 56),
                                text: activeStep == 0 ? 'ต่อไป' : 'เสร็จสิ้น',
                                onTap: () {
                                  setState(() {
                                    activeStep = 1;
                                  });
                                },
                              ),
                              if (activeStep >= 1) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                ButtonEvent(
                                  borderRadius: 8,
                                  bg: Color(0xff274DAE),
                                  shadow: Color.fromARGB(255, 28, 55, 123),
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
