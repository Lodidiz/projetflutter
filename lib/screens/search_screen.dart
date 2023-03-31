import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/bloc/search_bloc.dart';
import 'package:projet/widgets/search_game_card.dart';

class ScreenSearchPage extends StatelessWidget {
  const ScreenSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      appBar: AppBar(
        title: const Text(
          'Recherche',
          style: TextStyle(
            fontFamily: 'GoogleSansBold',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff1a2025),
        elevation: 2.5,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset('res/Icones/close.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color(0xff1a2025),
            padding: const EdgeInsets.all(16.0),
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
                          fontSize: 13,
                          fontFamily: 'Proxima',
                          color: Color(0xffedf0f3),
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (String searchTerm) {
                        BlocProvider.of<SearchBloc>(context).add(
                            FetchSearchedGamesEvent(searchTerm: searchTerm));
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(
                    Icons.search,
                    color: Color(0xff636af6),
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                BlocConsumer<SearchBloc, SearchState>(
                  listener: (BuildContext context, SearchState state) {
                    if (state is SearchErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (BuildContext context, SearchState state) {
                    if (state is SearchFetchState) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GameSearchCard(
                                  gamesearch: state.SearchedGames[index]),
                            );
                          },
                          childCount: state.SearchedGames.length,
                        ),
                      );
                    } else if (state is SearchErrorState) {
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
    );
  }
}
