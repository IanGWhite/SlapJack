import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'my_game.dart';

class Pipe extends SpriteComponent {
  final bool isTop;
  static Sprite? pipeSprite;

  Pipe({required Vector2 position, required Vector2 size, this.isTop = false, required Sprite sprite})
      : super(
          position: position,
          sprite: sprite,
          size: size,
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {

    if (isTop) {
      scale.y = -1;
      position.y -= size.y;
    }

    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += Vector2(-speed * dt, 0);

    if (position.x + size.x < 0) {
      removeFromParent();
    }

    super.update(dt);
  }
}
