import 'package:dice_roller/cardStack.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';



const speed = 80;
const gapInSeconds = 1;
const gravity = 900;


class MyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late double baseHeight;
  late Sprite baseSprite;
  late Sprite mySprite;
  late Sprite? myCardSprite1;
  int lives = 3;
  Text myText = Text('');

  late final TextComponent scoreText;
  int score = 0;

  double delta = 0;
  String cardStack = "1";
  final List<SpriteComponent> bases = [];

  final Function() onGameOver;

  MyGame({
    required this.onGameOver,
    });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final sprite = await loadSprite('BACK.png');
    myCardSprite1 = await loadSprite('BACK.png');

    baseSprite = await loadSprite('HA.png');
    mySprite = await loadSprite('BACK.png');
    
    // Load score text
    scoreText = TextComponent(
      text: 'Score: $score',
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    )..position = Vector2(10, 10);
    add(scoreText);

    final background1 = SpriteComponent()..sprite = sprite;
    Size screenSize = WidgetsBinding.instance.window.physicalSize;
    double width = screenSize.width;
    double height = screenSize.height;

    background1.size = Vector2(width, height);

    //add(background1);
    
    CardStack cardStack = CardStack(position: Vector2((width/2)-48, (height/2)-64), size: Vector2(96, 128), sprite: sprite);
    add(cardStack);
    /*
    character = Bird(
      position: Vector2(100, size.y / 2),
      size: Vector2(50, 35),
      bottom: (size.y - baseHeight / 2),
      spriteName: birdSprite,
      onGameOver: onGameOver,
    )..debugMode = true;
    */
    /*
    Pipe pipe =
        Pipe(position: Vector2((size.x / 2)+50, size.y+100), size: Vector2(100, 400))
          ..debugMode = true;
    Pipe pipe2 =
        Pipe(position: Vector2((size.x / 2)+50, (size.y/2)-100), size: Vector2(100, 400), isTop: true)
        ..debugMode = true;
    */
    //add(character);
    /*
    add(pipe);
    add(pipe2);
    */
    reloadBases();
  }

  @override
  void onTapDown(TapDownInfo info) {
    if(cardStack == "SJ" || cardStack == "CJ" || cardStack == "HJ" || cardStack == "DJ"){
      score += 1;
      scoreText.text = 'Score: $score';

    }else{
      lives--;
    }


  }

  @override
  void update(double dt) {
    delta += dt;
    var rng = Random();

    Size screenSize = WidgetsBinding.instance.window.physicalSize;
    double width = screenSize.width;
    double height = screenSize.height;





    if (delta > gapInSeconds) {
          final othercardStack =
    CardStack(position: Vector2(((width/2)-48)-50, ((height/2)-64)-50), size: Vector2(96, 128), sprite: mySprite);
    add(othercardStack);

    
        if(lives <= 0){
      onGameOver();
    }else{
      if(lives > 2){
        final heart1 =
        CardStack(position: Vector2(((width/2)-48)-100, ((height/2)-64)-200), size: Vector2(96, 128), sprite: baseSprite);
        add(heart1);
      }
      if(lives > 1){
        final heart2 =
        CardStack(position: Vector2(((width/2)-48), ((height/2)-64)-200), size: Vector2(96, 128), sprite: baseSprite);
      add(heart2);
      }
      if(lives > 0){
        final heart3 =
        CardStack(position: Vector2(((width/2)-48)+100, ((height/2)-64)-200), size: Vector2(96, 128), sprite: baseSprite);
      add(heart3);
      }
    }
    


      delta %= gapInSeconds; 
      cardStack = "${newSpriteImage(rng.nextInt(52)+1)}";
      reloadSprite(cardStack);
      reloadBases();
    }

    super.update(dt);
  }

  void reloadBases() {

  }

  void reloadSprite(String imagename) async {

    Size screenSize = WidgetsBinding.instance.window.physicalSize;
    double width = screenSize.width;
    double height = screenSize.height;

    myCardSprite1 = await loadSprite('${imagename}.png');
    final newcardStack =
    CardStack(position: Vector2((width/2)-48, (height/2)-64), size: Vector2(96, 128), sprite: myCardSprite1!);
    add(newcardStack);
  }

  String newSpriteImage(int number){
    String spriteImage = "BACK.png";
    String suit = "";
    if(number<=13){
      suit = "S";
      if(number == 1){
        spriteImage = "${suit}A";
      }else if(number == 11){
        spriteImage = "${suit}J";
      }else if (number == 12){
        spriteImage = "${suit}Q";
      }else if (number == 13){
        spriteImage = "${suit}K";
      }else {
        spriteImage = "$suit$number";
      }
    }else if(number > 13 && number <=26){
      suit = "C";
      if(number-13 == 1){
        spriteImage = "${suit}A";
      }else if(number-13 == 11){
        spriteImage = "${suit}J";
      }else if (number-13 == 12){
        spriteImage = "${suit}Q";
      }else if (number-13 == 13){
        spriteImage = "${suit}K";
      }else {
        spriteImage = "$suit${number-13}";
      }
      
    }else if(number > 26 && number <= 39){
      suit = "H";
      if(number-26 == 1){
        spriteImage = "${suit}A";
      }else if(number-26 == 11){
        spriteImage = "${suit}J";
      }else if (number-26 == 12){
        spriteImage = "${suit}Q";
      }else if (number-26 == 13){
        spriteImage = "${suit}K";
      }else {
        spriteImage = "$suit${number-26}";
      }
    }else{
      suit = "D";
      if(number-39 == 1){
        spriteImage = "${suit}A";
      }else if(number-39 == 11){
        spriteImage = "${suit}J";
      }else if (number-39 == 12){
        spriteImage = "${suit}Q";
      }else if (number-39 == 13){
        spriteImage = "${suit}K";
      }else {
        spriteImage = "$suit${number-39}";
      }
    }
    return spriteImage;
  }

}
