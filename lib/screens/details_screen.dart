import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet/bloc/detail_bloc.dart';
import 'package:projet/models/game.dart';
import 'package:projet/models/game_search.dart';

class DetailsScreen<T> extends StatefulWidget {
  final T gameOrSearch;

  DetailsScreen({required this.gameOrSearch});

  @override
  _DetailsScreenState<T> createState() => _DetailsScreenState<T>();
}

class _DetailsScreenState<T> extends State<DetailsScreen<T>> {
  bool isLiked = false;
  bool isInWishlist = false;

  late String gameName;
  late String gamePublisher;
  late String gameDetailedDescription;
  late String headerImageUrl;
  late String pathThumbnailUrl;
  late String gameBgContainerUrl;
  late String gameId;

  @override
  void initState() {
    super.initState();
    if (T == Game) {
      Game game = widget.gameOrSearch as Game;
      gameId = game.id.toString();
      gameName = game.name;
      gamePublisher = game.publisher;
      gameBgContainerUrl = game.backgroundUrl;
      gameDetailedDescription = game.detailedDescription;
      headerImageUrl = game.headerImageUrl;
      pathThumbnailUrl = game.pathThumbnailUrl;
    } else if (T == GameSearch) {
      GameSearch gameSearch = widget.gameOrSearch as GameSearch;
      gameId = gameSearch.id.toString();
      gameName = gameSearch.name;
      gamePublisher = gameSearch.publisher;
      gameBgContainerUrl = gameSearch.backgroundUrl;
      gameDetailedDescription = gameSearch.detailedDescription;
      headerImageUrl = gameSearch.headerImageUrl;
      pathThumbnailUrl = gameSearch.pathThumbnailUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailBloc>(
      create: (BuildContext context) => DetailBloc(gameId),
      child: Scaffold(
        backgroundColor: const Color(0xff1a2025),
        appBar: AppBar(
          title: const Text(
            'Détail du jeu',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'GoogleSansBold',
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff1a2025),
          elevation: 2.5,
          leading: IconButton(
            icon: SvgPicture.asset('res/Icones/back.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            BlocBuilder<DetailBloc, DetailState>(
              builder: (BuildContext context, DetailState state) {
                if (state is DetailInitial) {
                  isLiked = state.isLik;
                  isInWishlist = state.isWish;
                } else if (state is DetailLiked) {
                  isLiked = state.isLiked;
                }

                return IconButton(
                  icon: SvgPicture.asset(
                    isLiked
                        ? 'res/Icones/like_full.svg'
                        : 'res/Icones/like.svg',
                  ),
                  onPressed: () {
                    BlocProvider.of<DetailBloc>(context).add(LikeEvent(gameId));
                  },
                );
              },
            ),
            BlocBuilder<DetailBloc, DetailState>(
              builder: (BuildContext context, DetailState state) {
                if (state is DetailInitial) {
                  isInWishlist = state.isWish;
                } else if (state is DetailWishlisted) {
                  isInWishlist = state.isInWishlist;
                }
                return IconButton(
                  icon: SvgPicture.asset(
                    isInWishlist
                        ? 'res/Icones/whishlist_full.svg'
                        : 'res/Icones/whishlist.svg',
                  ),
                  onPressed: () {
                    BlocProvider.of<DetailBloc>(context)
                        .add(WishlistEvent(gameId));
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: Image.network(
                      pathThumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: const Color(0xff1a2025),
                    child: Html(
                      data: gameDetailedDescription,
                      style: <String, Style>{
                        'body': Style(
                          fontSize: FontSize(15.0),
                          color: Colors.white,
                          fontFamily: 'Proxima',
                        ),
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.387,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff1e262c),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x4c000000),
                        offset: Offset(0, 0),
                        blurRadius: 2.5,
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(gameBgContainerUrl),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(headerImageUrl),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              gameName,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xffffffff),
                                fontFamily: 'Proxima',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              gamePublisher,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                                fontFamily: 'Proxima',
                              ),
                            ),
                          ],
                        ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
