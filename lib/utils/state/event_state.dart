import 'package:get/get.dart';
import 'package:my_event_flutter/utils/models/model_event.dart';
import 'package:my_event_flutter/utils/services/native_api_service.dart';

class EventState extends GetxController {
  final List<EventModel> events = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await load();
  }

  Future<void> load() async {
    events.clear();
    final response = await NativeApiService.get("events");
    Map data = response;
    print('data: $data');
    List<EventModel> loadEvents = List<EventModel>.from(data['data'].map((x) => EventModel.fromJson(x)));
    events.addAll(loadEvents);
  }
}