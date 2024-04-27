import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/model_event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event, this.color});

  final EventModel event;
  final Color? color;
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
                decoration: BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                margin: EdgeInsets.only(right: 10),
                child: Center(child: Text(''))),
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
                        Icon(
                          Icons.check_circle,
                          color: Color(0xff27AE4D),
                        ),
                      if (event.booking)
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff27AE4D),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        '10.2km',
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
