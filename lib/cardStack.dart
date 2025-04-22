import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'my_game.dart';

const lifetimeInSeconds = 3.5;


class CardStack extends SpriteComponent {
  static Sprite? pipeSprite;
  double delta = 0;
  bool alive = true;

  CardStack({required Vector2 position, required Vector2 size, required Sprite sprite})
      : super(
          position: position,
          sprite: sprite,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    return super.onLoad();
  }

  @override
  void update(double dt) {
    delta += dt;
    if (delta > gapInSeconds) {
      removeFromParent();
    }
    if(alive == false){
      removeFromParent();
    }
    

    super.update(dt);
  }
}
