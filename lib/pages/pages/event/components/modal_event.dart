import 'package:flutter/material.dart';

import 'button_event.dart';

class ModalEvent extends StatefulWidget {
  const ModalEvent({super.key});

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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "รหัสผู้เข้าร่วมงาน",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1D358J',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
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
                        bg: Color(0xff274DAE),
                        shadow: Color.fromARGB(255, 29, 58, 130),
                        text: '',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: ButtonEvent(
                        vertical: 15,
                        borderRadius: 15,
                        color: Colors.black,
                        bg: Color(0xffF0F0F0),
                        shadow: Color.fromARGB(255, 171, 171, 171),
                        text: 'เปิดแผนที่',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ButtonEvent(
                        vertical: 8,
                        borderRadius: 15,
                        color: Colors.white,
                        bg: Color(0xffC02E2E),
                        shadow: Color.fromARGB(255, 141, 34, 34),
                        text: 'ยกเลิกการเข้าร่วม',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
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
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
