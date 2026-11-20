import 'package:flutter_test/flutter_test.dart';
import 'package:game_031_traffic_racer/core/arcade.dart';
import 'package:game_031_traffic_racer/core/level_plan.dart';
import 'package:game_031_traffic_racer/game/road_engine.dart';
import 'package:game_031_traffic_racer/game/rules.dart';

void main() {
  final rules = TrafficRules();
  final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: rules.optionalMechanics);

  test('holding the finger to the right steers right, the car accelerates', () {
    final s = RoadSim(rules.build(planner.spec(1)).puzzle);
    final x0 = s.x;
    for (var i = 0; i < 30; i++) {
      s.tick(const ArcadeInput(down: true, x: 950, y: 900));
    }
    expect(s.x, greaterThan(x0));
    expect(s.speed, greaterThan(0));
    expect(s.dist, greaterThan(0));
  });

  test('braking zone slows the vehicle down', () {
    final a = RoadSim(rules.build(planner.spec(1)).puzzle);
    final b = RoadSim(rules.build(planner.spec(1)).puzzle);
    for (var i = 0; i < 200; i++) {
      a.tick(ArcadeInput(down: true, x: a.x, y: 900));
      b.tick(ArcadeInput(down: true, x: b.x, y: kBrakeY + 50));
    }
    expect(b.speed, lessThan(a.speed));
  });

  test('every row leaves a free lane and the road stays on screen', () {
    final s = RoadSim(rules.build(planner.spec(4000)).puzzle);
    for (var i = 0; i < 1200; i++) {
      s.tick(rules.bot(s));
      final c = s.center(s.dist + 900);
      expect(c - s.level.halfW, greaterThanOrEqualTo(0));
      expect(c + s.level.halfW, lessThanOrEqualTo(kWorldW));
    }
  });

  test('a copy is independent of the original', () {
    final s = RoadSim(rules.build(planner.spec(30)).puzzle);
    for (var i = 0; i < 300; i++) {
      s.tick(rules.bot(s));
    }
    final c = s.copy();
    for (var i = 0; i < 100; i++) {
      c.tick(const ArcadeInput(down: true, x: 100, y: 900));
    }
    expect(s.ticks, 300);
    expect(c.ticks, 400);
    expect(identical(s.objs, c.objs), isFalse);
  });

  test('nitro booster raises the speed', () {
    final s = RoadSim(rules.build(planner.spec(2)).puzzle);
    for (var i = 0; i < 400; i++) {
      s.tick(rules.bot(s));
    }
    final v = s.speed;
    expect(s.useBooster(), isTrue);
    for (var i = 0; i < 120; i++) {
      s.tick(rules.bot(s));
    }
    expect(s.speed, greaterThan(v * 1.05));
  });
}
