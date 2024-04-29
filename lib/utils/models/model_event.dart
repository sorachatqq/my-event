import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class EventModel {
  final String? id;
  final String? image;
  final String? name;
  final String? detail;
  final bool verify;
  final bool booking;
  final LatLng? location;
  final int? gender;
  final List? age;
  final int? type;
  final String? startedAt;
  final String? locationName;
  final String? category;

  EventModel({
    this.id,
    this.image = '',
    this.name,
    this.detail,
    this.verify = false,
    this.booking = false,
    this.location,
    this.gender,
    this.age,
    this.type,
    this.startedAt,
    this.locationName,
    this.category
  });

  factory EventModel.fromJson(Map json) {
    Map item = json;
    List age = [];
    bool verify = false;
    bool booking = false;
    LatLng location = const LatLng(0, 0);
    return EventModel(
      id: item['id'],
      name: item['name'],
      detail: item['detail'],
      verify: verify,
      booking: booking,
      location: location,
      gender: item['gender'],
      age: age,
      type: item['type'],
      startedAt: item['started_at'],
      category: item['category'],
    );
  }

  String getStartedAt() {
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");
    return format.format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(startedAt ?? DateTime.now().toUtc().toIso8601String()));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "detail": detail,
        "location": location,
        "gender": gender,
        "age": age,
        "type": type,
        "started_at": startedAt,
        "location_name": locationName,
        "category": category
      };
}
