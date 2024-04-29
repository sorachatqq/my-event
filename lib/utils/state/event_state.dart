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

  @override
  void dispose() {
    events.clear();
    super.dispose();
  }

  void init() async {
    events.clear();
    await load();
  }

  Future<void> load() async {
    events.clear();
    final response = await NativeApiService.get("events");
    List<dynamic> data = response;
    List<EventModel> loadEvents = List<EventModel>.from(data.map((x) => EventModel.fromJson({
      ...x,
      "id": x['_id'].toString(),
      "latitude": x['location']['coordinates'][0].toString(),
      "longitude": x['location']['coordinates'][1].toString(),
      "locationName": x['location']['name'] ?? "Unknown",
    })));
    events.clear();
    events.addAll(loadEvents);
  }
}