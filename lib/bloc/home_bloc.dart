import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/game.dart';
import 'package:projet/repositories/steam_api_repository.dart';

// Événements
abstract class HomeEvent {}

class FetchMostPlayedGamesEvent extends HomeEvent {}

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeMostPlayedGamesFetchedState extends HomeState {
  final List<Game> mostPlayedGames;

  HomeMostPlayedGamesFetchedState(this.mostPlayedGames);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SteamApiRepository _steamApiRepository;

  HomeBloc({required SteamApiRepository steamApiRepository})
      : _steamApiRepository = steamApiRepository,
        super(HomeInitialState()) {
    on<FetchMostPlayedGamesEvent>(_onFetchMostPlayedGamesEvent);
  }

  Future<void> _onFetchMostPlayedGamesEvent(
      FetchMostPlayedGamesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final List<Game> mostPlayedGames =
          await _steamApiRepository.fetchMostPlayedGames();
      emit(HomeMostPlayedGamesFetchedState(mostPlayedGames));
    } catch (error) {
      emit(HomeErrorState(error.toString()));
    }
  }
}
