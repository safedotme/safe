class Location {
  final double lat;
  final double long;
  final double alt;
  final DateTime datetime;
  final String? address;

  Location({
    required this.lat,
    required this.long,
    required this.alt,
    required this.datetime,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        long: json["long"],
        alt: json["alt"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "long": long,
        "alt": alt,
        "datetime": datetime.toIso8601String(),
        "address": address,
      };
}
