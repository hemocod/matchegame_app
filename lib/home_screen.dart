import 'package:flutter/material.dart';
import 'package:matchegame_app/item_model.dart';
// ignore: unused_import
import 'package:matchegame_app/Home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late int score;
  late bool gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: 'lion', name: 'lion', img: 'assets/image/lion.png'),
      ItemModel(value: 'camel', name: 'Camle', img: 'assets/image/camel.png'),
      ItemModel(value: 'cat', name: 'Cat', img: 'assets/image/cat.png'),
      ItemModel(value: 'cow', name: 'Cow', img: 'assets/image/cow.png'),
      ItemModel(value: 'dog', name: 'Dog', img: 'assets/image/dog.png'),
      ItemModel(value: 'fox', name: 'Fox', img: 'assets/image/fox.png'),
      ItemModel(value: 'hen', name: 'Hen', img: 'assets/image/hen.png'),
      ItemModel(value: 'dolphin', name: 'dolphin', img: 'assets/image/dolphin.png'),
      ItemModel(value: 'bee', name: 'Bee', img: 'assets/image/bee.png'),
      ItemModel(value: 'butterfly', name: 'Butterfly', img: 'assets/image/butterfly.png'),
      ItemModel(value: 'dinosaur', name: 'Dinosaur', img: 'assets/image/dinosaur.png'),
      ItemModel(value: 'elephant', name: 'elephant', img: 'assets/image/elephant.png'),
      ItemModel(value: 'forg', name: 'Frog', img: 'assets/image/frog.png'),
      ItemModel(value: 'octopus', name: 'Octopus', img: 'assets/image/octopus.png'),
      ItemModel(value: 'owl', name: 'Owl', img: 'assets/image/owl.png'),
      ItemModel(value: 'tiger', name: 'Tiger', img: 'assets/image/tiger.png'),
      ItemModel(value: 'toucan', name: 'Toucan', img: 'assets/image/toucan.png'),
      ItemModel(value: 'ostrich', name: 'Ostrich', img: 'assets/image/ostrich.png'),
    ];

    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 190, 105),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Score: ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextSpan(
                      text: '$score',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                Column(
                  children: items.map((item) {
                    return Container(
              
                      child: Draggable<ItemModel>(
                          
                        data: item,
                        childWhenDragging: CircleAvatar(
                          backgroundColor: Colors.grey,

                          radius: 40,
                           
                          backgroundImage: AssetImage(item.img),
                          
                        ),
                        feedback: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40,
                          
                          backgroundImage: AssetImage(item.img),


                        ),
                        child: CircleAvatar(
                          
                          radius: 40,
                          backgroundImage: AssetImage(item.img),

                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (!gameOver)
                  Spacer(
                    flex: 2,
                  ),
                Column(
                  children: items2.map((item) {
                    return DragTarget<ItemModel>(
                      
                      onAccept: (receivedItem) {
                        if (receivedItem.value == item.value) {
                          setState(() {
                            items.remove(receivedItem);
                            items2.remove(item);
                          });
                          score += 10;
                          items.shuffle();
                        } else {
                          setState(() {
                            score -= 5;
                          });
                        }
                      },
                      onWillAccept: (receivedItem) {
                        setState(() {});
                        return true;
                      },
                      onLeave: (receivedItem) {
                        setState(() {});
                      },
                      builder: (context, acceptedItems, rejectedItems) {
                        return Container(
                          
                          decoration: BoxDecoration(
                            color: acceptedItems.isEmpty
                                ? Color.fromARGB(255, 204, 62, 140)
                                : Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6,
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 40,
                          
                            child: Text(item.name),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Game Over',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ),
            if (gameOver)
              Container(
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      initGame();
                    });
                  },
                  child: Text(
                    'Play Again',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }

  //function to display the result
  String result() {
    if (score == 100) {
      return 'Awesome';
    } else {
      return 'Please Try Again';
    }
  }
}
