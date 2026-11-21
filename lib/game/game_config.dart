import 'package:flutter/material.dart';

import 'package:studio_core/app/arcade_stage.dart';
import 'package:studio_core/app/game_api.dart';
import 'package:studio_core/core/game_rules.dart';
import 'road_engine.dart';
import 'drive_view.dart';
import 'rules.dart';

const _theme = DriveTheme(Color(0xFF3A5A40), Color(0xFF495057), Color(0xFFF8F9FA), Color(0xFFFFB703));



final gameConfig = GameConfig(
  gameId: 'game-031-traffic-racer',
  title: const ['Trafik Yarışçısı', 'Traffic Racer', 'Traffic Racer', 'Traffic Racer', 'Traffic Racer'],
  tagline: const ['Trafiğin arasından tam gaz süzül!', 'Weave through traffic at full throttle!', 'Weave through traffic at full throttle!', 'Weave through traffic at full throttle!', 'Weave through traffic at full throttle!'],
  seedColor: const Color(0xFFFFB703),
  icon: Icons.directions_car,
  rules: TrafficRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => RoadSim((ctx.generated as GeneratedLevel<RoadLevel>).puzzle),
    paint: (c, s, p, t) => paintRoad(c, s, p, t, ctx.lang == 'tr', _theme),
    sound: roadSound,
    boosterIcon: Icons.bolt,
    boosterLabel: (l) => l == 'tr' ? 'Nitro' : 'Nitro',
    howTo: const [
      'Parmağını sola/sağa kaydırarak şerit değiştir; aşağıdaki şeritte basılı tutarak fren yap. Hedef mesafeye ulaş.',
      'Slide your finger to change lanes; hold in the bottom strip to brake. Reach the target distance.',
      'Slide your finger to change lanes; hold in the bottom strip to brake. Reach the target distance.',
      'Slide your finger to change lanes; hold in the bottom strip to brake. Reach the target distance.',
      'Slide your finger to change lanes; hold in the bottom strip to brake. Reach the target distance.',
    ],
  ),
  tutorial: const [
    TutorialStep(Icons.swipe, [
      'Parmağını ekranda sola/sağa kaydır: araç parmağını izler. Klavye: ← →, fren ↓.',
      'Slide your finger left/right: the vehicle follows it. Keyboard: ← →, brake ↓.',
      'Finger nach links/rechts: das Fahrzeug folgt. Tastatur ← →.',
      'Desliza el dedo: el vehículo lo sigue. Teclado ← →.',
      'Glissez le doigt : le véhicule suit. Clavier ← →.',
    ]),
    TutorialStep(Icons.pan_tool, [
      'Parmağını en alttaki şeritte tutarsan fren yaparsın.',
      'Hold your finger in the bottom strip to brake.',
      'Finger unten halten = bremsen.',
      'Mantén el dedo abajo para frenar.',
      'Gardez le doigt en bas pour freiner.',
    ]),
    TutorialStep(Icons.bolt, [
      'Nitro güçlendirmesi 4 sn hızlandırır ve korur.',
      'Nitro boosts and protects you for 4 s.',
      'Nitro: 4 s schneller und geschützt.',
      'Nitro: 4 s más rápido y protegido.',
      'Nitro : 4 s plus vite et protégé.',
    ]),
  ],
);
