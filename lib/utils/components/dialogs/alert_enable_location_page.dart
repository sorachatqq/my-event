import 'package:flutter/material.dart';


class AlertEnableLocationPage extends StatefulWidget {
  const AlertEnableLocationPage({Key? key}) : super(key: key);

  @override
  State<AlertEnableLocationPage> createState() => _AlertEnableLocationPageState();
}

class _AlertEnableLocationPageState extends State<AlertEnableLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text("การเข้าถึงตำแหน่ง",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "แอปนี้รวบรวมข้อมูลตำแหน่งเพื่อเปิดใช้งานบริการตำแหน่งและบริการตำแหน่งพื้นหลังเมื่อแอปใช้งานเวลาทำงานในการจัดส่งเท่านั้น",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "ขอแนะนำว่าให้ทำการเปิดกสนระบุตำแหน่งเพื่อประโยชน์ของท่าน และความแม่นยำในการใช้งาน",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
         ],
        ),
      ),
    );
  }
}
