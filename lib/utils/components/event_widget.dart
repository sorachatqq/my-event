import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_event_flutter/utils/state/location_state.dart';

import '../models/model_event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event, this.color, required this.locationController});

  final EventModel event;
  final Color? color;
  final LocationState locationController;

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(context.namedLocation('event-view',
            pathParameters: {"id": event.id.toString()}));
      },
      child: Container(
        child: Row(
          children: [
            Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                margin: const EdgeInsets.only(right: 10),
                child: const Center(child: Text(''))),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${event.name}',
                          maxLines: 1,
                          style: TextStyle(
                              color: color,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (event.verify)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xff27AE4D),
                        ),
                      if (event.booking)
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff27AE4D),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'จองแล้ว',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                    ],
                  ),
                  Text(
                    '${event.detail}',
                    maxLines: 3,
                    style: TextStyle(color: color),
                  ),
                  Row(
                    children: [
                      Text(
                        '${getDistance(event.location ?? const LatLng(0, 0)).toPrecision(2)}km',
                        style: TextStyle(color: color),
                      ),
                      Icon(
                        Icons.pin_drop,
                        color: color,
                        size: 15,
                      ),
                      Expanded(
                          child: Text(
                        'อิมแพคอารีนา เมืองทองธานี',
                        style: TextStyle(color: color),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
