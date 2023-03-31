//import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projet/models/game.dart';
import 'package:projet/screens/details_screen.dart';

class GameCard extends StatelessWidget {
  final Game game;

  GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 100;

    return InkWell(
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: const Color(0xff1e262c),
          borderRadius: BorderRadius.circular(3.5228872299),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(game.backgroundUrl),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x4c000000),
              offset: Offset(0, 0),
              blurRadius: 2.5,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(
                  5.0),
              child: Container(
                width: 110,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                  child: Image.network(
                    game.headerImageUrl,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        game.name,
                        style: const TextStyle(
                          fontFamily: 'Proxima',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        game.publisher,
                        style: const TextStyle(
                          fontFamily: 'Proxima',
                          fontSize: 11,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    const   SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Proxima',
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                          color: Color(0xffffffff),
                          decorationColor: Color(0xffffffff),
                        ),
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Prix : ',
                          ),
                          TextSpan(
                            text: game.price,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => DetailsScreen<Game>(
                          gameOrSearch: game,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 100,
                    height: cardHeight,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      color: Color(0xff636af6),
                    ),
                    child: const Text(
                      'En savoir\nplus',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
