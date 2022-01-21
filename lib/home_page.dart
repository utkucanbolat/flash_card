import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool shuffleState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          shuffleState ? Icons.shuffle : Icons.shuffle_on,
          color: Colors.black,
        ),
        focusElevation: 1.0,
        highlightElevation: 1.0,
        elevation: 1.0,
        disabledElevation: 1.0,
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            shuffleState ? shuffleState = false : shuffleState = true;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              itemCount: mainCardList.length,
              itemBuilder: (BuildContext context, int itemIndex) =>
                  FlipCardBuilder(itemIndex, shuffleState),
            ),
          ],
        ),
      ),
    );
  }
}

int itemShuffler(int itemIndex, bool shuffleState, int listSize) {
  Random random = Random();
  if (shuffleState) {
    return itemIndex;
  } else {
    return random.nextInt(listSize) + itemIndex % listSize;
  }
}


class GermanCard extends StatelessWidget {
  GermanCard(this.index);

  final int index;
  final List cardList = mainCardList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cardList[index % cardList.length].ger,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              cardList[index % cardList.length].plural == ""
                  ? ""
                  : "Pl. " + cardList[index % cardList.length].plural,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EnglishCard extends StatelessWidget {
  EnglishCard(this.index);

  final int index;
  final List cardList = mainCardList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cardList[index % cardList.length].eng,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}


class FlipCardBuilder extends StatelessWidget {
  FlipCardBuilder(this.itemIndex, this.shuffleState);

  final int itemIndex;
  final bool shuffleState;

  @override
  Widget build(BuildContext context) {
    var _shuffledIndex =
        itemShuffler(itemIndex, shuffleState, mainCardList.length);

    return Container(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: GermanCard(_shuffledIndex),
        back: EnglishCard(_shuffledIndex),
      ),
    );
  }
}
