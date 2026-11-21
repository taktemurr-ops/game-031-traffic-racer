import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/missions.dart';
import 'package:studio_core/core/stats.dart';
import 'road_rules.dart';
import 'traffic_spec.dart';

class TrafficRules extends RoadRules {
  TrafficRules()
      : super(trafficSpec, 'game-031-traffic-racer', const [
          GameStat('distance_m', 'Gidilen yol (m)', 'Distance (m)', scale: 5000),
          GameStat('near_misses', 'Kıl payı geçiş', 'Near misses', scale: 50),
          GameStat('coins', 'Jeton', 'Coins', scale: 100),
        ], const [
          MissionTemplate('distance_m', 'distance_m', [1666, 3333, 5000]),
          MissionTemplate('near_misses', 'near_misses', [16, 33, 50]),
        ]);
}

ArcadeRules createRules() => TrafficRules();
