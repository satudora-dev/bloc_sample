class HealthProfile {
  DateTime date;
  String weight;
  String bodyTemperature;

  HealthProfile(this.date, this.weight, this.bodyTemperature);

  Map toJson() => {
        "date": date.toIso8601String(),
        "weight": weight,
        "bodyTemperature": bodyTemperature
      };

  static HealthProfile fromJson(jsonMap) => HealthProfile(
      DateTime.parse(jsonMap["date"]),
      jsonMap["weight"],
      jsonMap["bodyTemperature"]);
}
