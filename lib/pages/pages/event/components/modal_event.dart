import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'button_event.dart';

class ModalEvent extends StatefulWidget {
  double lat = 13.736717;
  double lng = 100.523186;
  
  ModalEvent({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  State<ModalEvent> createState() => _ModalEventState();
}

class _ModalEventState extends State<ModalEvent> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "รหัสผู้เข้าร่วมงาน",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1D358J',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
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
                        color: Colors.black,
                        bg: const Color(0xffF0F0F0),
                        shadow: const Color.fromARGB(255, 171, 171, 171),
                        text: 'เปิดแผนที่',
                        onTap: () {
                          launchUrl(Uri(
                            scheme: 'https',
                            host: 'www.google.com',
                            path: 'maps/search/',
                            queryParameters: {
                              'api': '1',
                              'query': [widget.lat, widget.lng].join(','),
                            },
                          ));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: InkWell(
                onTap: () {},
                child: SafeArea(
                  child: Container(),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
