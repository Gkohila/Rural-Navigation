import 'package:flutter_test/flutter_test.dart';
import 'package:smartnav/widgets/home/hero/weather_hero_scenario.dart';

void main() {
  group('WeatherHeroScenario', () {
    test('courtallam sunny morning dummy data', () {
      const s = WeatherHeroScenario.courtallamSunnyMorning;

      expect(s.location, 'Courtallam');
      expect(s.weather, 'Sunny');
      expect(s.timeLabel, 'Morning');
      expect(s.temperatureC, 24);
      expect(s.sceneType, HeroSceneType.sunnyMorning);
      expect(s.isNight, isFalse);
    });

    test('tenkasi night rain production preset', () {
      const s = WeatherHeroScenario.tenkasiNightRain;

      expect(s.location, 'Tenkasi Bus Stand');
      expect(s.weather, 'Light Rain');
      expect(s.timeLabel, 'Night');
      expect(s.sceneType, HeroSceneType.nightRain);
      expect(s.isNight, isTrue);
    });
  });
}
