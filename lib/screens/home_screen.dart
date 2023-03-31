import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/bloc/home_bloc.dart';
import 'package:projet/bloc/search_bloc.dart';
import 'package:projet/repositories/steam_api_repository.dart';
import 'package:projet/repositories/steam_api_repository_search.dart';
import 'package:projet/screens/likes_screen.dart';
import 'package:projet/screens/search_screen.dart';
import 'package:projet/screens/wishlist_screen.dart';
import 'package:projet/widgets/game_card.dart';
import 'package:projet/screens/details_screen_Jeudumoment.dart';
import '../bloc/favorite_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _pageLike(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => BlocProvider<FavoriteBloc>(
          create: (BuildContext context) => FavoriteBloc(),
          child: LikesScreen(),
        ),
      ),
    );
  }

  void _pageWhishlist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => BlocProvider<FavoriteBloc>(
          create: (BuildContext context) => FavoriteBloc(),
          child: WishlistScreen(),
        ),
      ),
    );
  }

  void onSearch(BuildContext context, String searchTerm) {
    SteamApiSearch steamApiRepositorySearch = SteamApiSearch();
    SearchBloc searchBloc =
    SearchBloc(steamApiRepositorySearch: steamApiRepositorySearch);
    searchBloc.add(FetchSearchedGamesEvent(searchTerm: searchTerm));

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BlocProvider<SearchBloc>.value(
          value: searchBloc,
          child: const ScreenSearchPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      appBar: AppBar(
        title: const Text(
          'Accueil',
          style: TextStyle(
            fontFamily: 'GoogleSansBold',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff1a2025),
        elevation: 2.5,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset('res/Icones/like.svg'),
            onPressed: () {
              _pageLike(context);
            },
          ),
          IconButton(
            icon: SvgPicture.asset('res/Icones/whishlist.svg'),
            onPressed: () {
              _pageWhishlist(context);
            },
          ),
        ],
      ),
      body: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(
          steamApiRepository: SteamApiRepository(),
        )..add(FetchMostPlayedGamesEvent()),
        child: Column(
          children: <Widget>[
            Container(
              color: const Color(0xff1a2025),
              padding: const EdgeInsets.all(13.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xff1e262c),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Rechercher un jeu…',
                          hintStyle: TextStyle(
                            fontFamily: 'Proxima',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffedf0f3),
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onSubmitted: (String searchTerm) =>
                            onSearch(context, searchTerm),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        color: Color(0xff636af6),
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0.1),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('res/Jeudumoment/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          const Positioned(
                            top: 70,
                            left: 12,
                            child: Text(
                              'ARK: Survival Evolved',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Proxima',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 12,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreenJeuDuMoment(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xff636AF6),
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'En savoir plus',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'Proxima',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12, // Padding depuis le bas
                            right: 12, // Padding depuis la droite
                            child: Image.asset(
                              'res/Jeudumoment/box.jpg',
                              width: 90,
                              height: 130,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      'Les meilleures ventes',
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: Color(0xffffffff),
                        decorationColor: Color(0xffffffff),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 0.1),
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (BuildContext context, HomeState state) {
                      if (state is HomeErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (BuildContext context, HomeState state) {
                      if (state is HomeMostPlayedGamesFetchedState) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GameCard(
                                    game: state.mostPlayedGames[index]),
                              );
                            },
                            childCount: state.mostPlayedGames.length,
                          ),
                        );
                      } else if (state is HomeErrorState) {
                        return const SliverFillRemaining(
                            child: Center(
                                child: Text(
                                    'Erreur lors de la récupération des jeux')));
                      } else {
                        return const SliverFillRemaining(
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
