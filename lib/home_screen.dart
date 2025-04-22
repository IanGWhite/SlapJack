import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';
import 'package:rive/rive.dart' as myRize;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}





class _HomeScreenState extends State<HomeScreen> {
String animationName = 'Smile';

void _smilePlease(){
  setState((){
    if(animationName == 'Smile'){
      animationName = 'Frown';
    } else {
      animationName = 'Smile';
      
    }
  });
}

void changePage(){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameWidget(
                    game: MyGame(
                  onGameOver: gameOver,
                )),
              ));
}


  void gameOver() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(
                  onPressed: () => changePage(), 
                  tooltip: "Erase Tasks", 
                  icon: const Icon(Icons.casino)
                  )],),
      body: Center(
        child: Container(
        width: 400,
        height: 400,
            child: myRize.RiveAnimation.asset('assets/smiley(3).riv', alignment: Alignment.center,
            fit: BoxFit.contain,
          animations: [animationName, 'Frown'],),
          ),
      ),
      
         floatingActionButton: FloatingActionButton(
        onPressed: _smilePlease,
        tooltip: 'Increment',
        child: Icon(Icons.add)),
      
    );
  }
}
