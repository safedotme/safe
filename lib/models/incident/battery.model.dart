class Battery {
  final double percentage;
  final DateTime datetime;

  Battery({
    required this.percentage,
    required this.datetime,
  });

  factory Battery.fromJson(Map<String, dynamic> json) => Battery(
        percentage: json["percentage"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "percentage": percentage,
        "datetime": datetime.toIso8601String(),
      };
}
