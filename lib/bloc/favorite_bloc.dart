import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/game_search.dart';
import 'package:projet/repositories/steam_api_fetch.dart';

abstract class FavoriteEvent {}

class FetchFavoriteGamesEvent extends FavoriteEvent {
  final bool isWishlist;
  FetchFavoriteGamesEvent({required this.isWishlist});
}

class RemoveFavoriteGameEvent extends FavoriteEvent {
  final int gameId;
  RemoveFavoriteGameEvent({required this.gameId});
}

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String error;
  FavoriteErrorState({required this.error});
}

class FavoriteFetchedState extends FavoriteState {
  final List<GameSearch> favoriteGames;
  FavoriteFetchedState({required this.favoriteGames});
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SteamApiFetch _steamApiFetch = SteamApiFetch();

  FavoriteBloc() : super(FavoriteInitialState()) {
    on<FetchFavoriteGamesEvent>(_onFetchFavoriteGamesEvent);
  }

  Future<void> _onFetchFavoriteGamesEvent(
      FavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (event is! FetchFavoriteGamesEvent) {
      return;
    }

    emit(FavoriteLoadingState());
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in.');
      }

      // Récupérer les gameId des collections 'likes' et 'wishlist'.
      List<int> gameIds = <int>[];
      QuerySnapshot<Object?> snapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection(event.isWishlist ? 'wishlist' : 'likes')
          .get();

      for (QueryDocumentSnapshot<Object?> doc in snapshot.docs) {
        gameIds.add(int.parse(doc.id));
      }

      // Supprime les doublons
      gameIds = gameIds.toSet().toList();

      // Récupérer les détails de chaque jeu avec fetchGameDetails
      List<GameSearch> favoriteGames = <GameSearch>[];
      for (int gameId in gameIds) {
        GameSearch gameSearch = await _steamApiFetch.fetchGameDetails(gameId);
        favoriteGames.add(gameSearch);
      }

      // Renvoyer les jeux récupérés
      emit(FavoriteFetchedState(favoriteGames: favoriteGames));
    } catch (error) {
      emit(FavoriteErrorState(error: error.toString()));
    }
  }
}
