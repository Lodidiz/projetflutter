import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet/bloc/favorite_bloc.dart';
import 'package:projet/models/game_search.dart';

import '../widgets/search_game_card.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FetchFavoriteGamesEvent(isWishlist: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      appBar: AppBar(
        title: const Text(
          'Ma liste de souhaits',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'GoogleSansBold',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff1a2025),
        elevation: 2.5,
        leading: IconButton(
          icon: SvgPicture.asset('res/Icones/close.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
          if (state is FavoriteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteErrorState) {
            return Center(child: Text(state.error));
          } else if (state is FavoriteFetchedState) {
            final List<GameSearch> favoriteGames = state.favoriteGames;

            if (favoriteGames.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('res/Icones/empty_whishlist.svg'),
                    const SizedBox(height: 16),
                    const Text(
                      'Vous n’avez encore pas liké de contenu.\nCliquez sur l\'étoile pour en rajouter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Proxima'),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: favoriteGames.length,
                itemBuilder: (BuildContext context, int index) {
                  final GameSearch gameSearch = favoriteGames[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GameSearchCard(gamesearch: gameSearch),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
