class HealthProfile {
  DateTime date;
  String height;
  String bodyTemperature;

  HealthProfile(this.date, this.height, this.bodyTemperature);

  Map toJson() =>
      {
        "date": date.toIso8601String(),
        "height": height,
        "bodyTemperature": bodyTemperature
      };

  static HealthProfile fromJson(jsonMap) => HealthProfile(
      DateTime.parse(jsonMap["date"]),
      jsonMap["height"],
      jsonMap["bodyTemperature"]);
}
