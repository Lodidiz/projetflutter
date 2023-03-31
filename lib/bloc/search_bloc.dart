import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/models/game_search.dart';
import 'package:projet/repositories/steam_api_repository_search.dart';

// Événements
abstract class SearchEvent {}

class FetchSearchedGamesEvent extends SearchEvent {
  final String searchTerm;

  FetchSearchedGamesEvent({required this.searchTerm});
}

// États
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchFetchState extends SearchState {
  final List<GameSearch> SearchedGames;

  SearchFetchState(this.SearchedGames);
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SteamApiSearch _steamApiRepositorySearch;

  SearchBloc({required SteamApiSearch steamApiRepositorySearch})
      : _steamApiRepositorySearch = steamApiRepositorySearch,
        super(SearchInitialState()) {
    on<FetchSearchedGamesEvent>(_onFetchSearchedGamesEvent);
  }

  Future<void> _onFetchSearchedGamesEvent(
      FetchSearchedGamesEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      final List<GameSearch> SearchedGames =
          await _steamApiRepositorySearch.searchGames(event.searchTerm);
      emit(SearchFetchState(SearchedGames));
    } catch (error) {
      emit(SearchErrorState(error.toString()));
    }
  }
}
