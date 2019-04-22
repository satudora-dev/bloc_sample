import "package:flutter_test/flutter_test.dart";

import '../lib/Model/HealthProfile.dart';
import '../lib/Repository/HealthProfileRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final healthProfileRepository = HealthProfileRepository();
    healthProfileRepository.reset();
  });

  test("health profileデータのshared_preferenceへの保存・取り出し", () async {
    final healthProfileRepository = HealthProfileRepository();
    final healthProfileList = [
      HealthProfile(DateTime.now(), "60", "36.0"),
      HealthProfile(DateTime.now(), "70", "37.0"),
      HealthProfile(DateTime.now(), "80", "38.0")
    ];
    for (var t in healthProfileList) {
      healthProfileRepository.save(t);
    }
    final allHealthProfileList =
        await healthProfileRepository.getAllHealthProfile();
    for (var i = 0; i < allHealthProfileList.length; i++) {
      expect(
          allHealthProfileList[i].weight, equals(healthProfileList[i].weight));
      expect(allHealthProfileList[i].date, equals(healthProfileList[i].date));
      expect(allHealthProfileList[i].bodyTemperature,
          equals(healthProfileList[i].bodyTemperature));
    }
  });

  test("health profileデータのreset", () async {
    final healthProfileRepository = HealthProfileRepository();
    healthProfileRepository.reset();
    healthProfileRepository.save(HealthProfile(DateTime.now(), "60", "36.0"));
    final allHealthProfileList =
        await healthProfileRepository.getAllHealthProfile();
    expect(allHealthProfileList.length, 1);
    await healthProfileRepository.reset();
    final allHealthProfileListAfterReset =
    await healthProfileRepository.getAllHealthProfile();
    expect(allHealthProfileListAfterReset, null);
  });
}
