import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class EventModel {
  final String? id;
  final String? picture;
  final String? name;
  final String? detail;
  final bool approved;
  final bool isRegistered;
  final LatLng? location;
  final int? gender;
  final List? age;
  final String? type;
  final String? startedAt;
  final String? locationName;
  final String? registrationCode;

  EventModel({
    this.id,
    this.picture = '',
    this.name,
    this.detail,
    this.approved = false,
    this.isRegistered = false,
    this.location,
    this.gender,
    this.age,
    this.type,
    this.startedAt,
    this.locationName,
    this.registrationCode,
  });

  factory EventModel.fromJson(Map json) {
    Map item = json;
    List age = [];
    LatLng location = const LatLng(0, 0);
    return EventModel(
      id: item['id'],
      picture: item['picture'],
      name: item['name'],
      detail: item['detail'],
      approved: item['approved'],
      isRegistered: item['is_registered'],
      location: location,
      gender: item['gender'],
      age: age,
      type: item['type'],
      startedAt: item['started_at'],
      registrationCode: item['registration_code'],
    );
  }

  String getStartedAt() {
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");
    return format.format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(startedAt ?? DateTime.now().toUtc().toIso8601String()));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "name": name,
        "detail": detail,
        "location": location,
        "gender": gender,
        "age": age,
        "type": type,
        "started_at": startedAt,
        "location_name": locationName,
        "is_registered": isRegistered,
        "registration_code": registrationCode,
      };
}
