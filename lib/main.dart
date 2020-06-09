import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:snake/object.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

//  Timer refresh;
  Timer operation;
  int speed = 1;

  int crossAxisCount;
  int numberOfSquares;
  List gridItmes = List<Color>();
  Object snake;
  Object apple;
  String direction = 'down';
  String beforeDirection = 'down';
  bool isThereMove = false;

  @override
  Widget build(BuildContext context) {
    crossAxisCount = 20;
    numberOfSquares = 600;
    gridItmes = List<Color>(numberOfSquares);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Container(
          child: controller(),
        ),
        bottomNavigationBar: Container(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  start(context: context);
                },
                child: Text(
                  'Start Game',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                '$counter',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector controller() {
    return GestureDetector(
      onVerticalDragUpdate: (d) {
        if (direction != 'down' && d.delta.direction < 0) {
          if (this.beforeDirection == this.direction) {
            direction = 'up';
          }
        } else if (direction != 'up' && d.delta.direction > 0) {
          if (this.beforeDirection == this.direction ){
            direction = 'down';
          }
        }
      },
      onHorizontalDragUpdate: (d) {
        if (direction != 'left' && d.delta.dx > 0) {
          if (this.beforeDirection == this.direction) {
            direction = 'right';
          }
        } else if (direction != 'right' && d.delta.dx < 0) {
          if (this.beforeDirection == this.direction) {
            direction = 'left';
          }
        }
      },
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: numberOfSquares,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, int counter) {
            merge;
            if (gridItmes[counter] != null) {
              return Container(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: gridItmes[counter],
                  ),
                ),
              );
            }
            return Container(
              padding: EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Colors.grey[800],
                ),
              ),
            );
          }),
    );
  }

  void start({BuildContext context}) {
    this.speed = 1;
    this.counter = 0;
    this.operation?.cancel();

    this.direction = 'down';
    Random random = new Random();
    this.apple = Object(
        color: Colors.green, coordinates: [random.nextInt(numberOfSquares)]);
    this.snake = Object(
        coordinates: [
          5 + (crossAxisCount),
          5 + (crossAxisCount * 2),
          5 + (crossAxisCount * 3),
          5 + (crossAxisCount * 4),
          5 + (crossAxisCount * 5),
          5 + (crossAxisCount * 6)
        ],
        color: Colors.white,
        rowLength: crossAxisCount,
        totalLength: numberOfSquares);
    void frame() {
      this.operation = Timer.periodic(
          Duration(milliseconds: 1000 ~/ (log(pow(speed, 2.5) + 10))), (timer) {
        setState(() {
          logic(context);
        });
        timer.cancel();
        frame();
      });
    }

    frame();
  }

  void logic(BuildContext context) {
    Random random = Random() ;
    if (snake.coordinates.last == apple.coordinates.first) {
      this.snake.grow(direction);
      this.counter++;
      this.speed++;
      while(true){
        var place = random.nextInt(this.numberOfSquares) ;
        if(!snake.coordinates.contains(place)){
          this.apple.coordinates.first = random ;
          break ;
        }
      }
      return ;
    }
    switch (direction) {
      case 'up':
        {
          snake.moveUp;
        }
        break;
      case 'down':
        {
          snake.moveDown;
        }
        break;
      case 'left':
        {
          snake.moveLeft;
        }
        break;
      case 'right':
        {
          snake.moveRight;
        }
        break;
    }
    this.beforeDirection = this.direction ;
    for (var i = 0; i < snake.coordinates.length - 1; i++) {
      if (snake.coordinates.last == snake.coordinates[i]) {
        showDialog(
            context: context,
            builder: (context) {
              this.operation.cancel();
              return Dialog(
                child: Text(
                  'Game is Over',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                  ),
                ),
              );
            });
      }
    }
  }

  void get merge {
    snake?.coordinates?.forEach((element) {
      gridItmes[element] = snake.color;
    });
    apple?.coordinates?.forEach((element) {
      gridItmes[element] = apple.color;
    });
  }
}
