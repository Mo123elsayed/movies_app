import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/local/watch_list_using_shared_preference.dart';
import 'package:movies_app/movies/data/models/movie.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial()) {
    _loadWatchList();
  }
  final WatchListUsingSharedPreference _savedMovies =
      WatchListUsingSharedPreference();
  List<Movie> watchList = [];

  Future<void> _loadWatchList() async {
    final movies = await _savedMovies.loadMovies();
    if (movies.isEmpty) {
      emit(WatchListEmpty());
    } else {
      watchList = movies;
      emit(WatchListLoaded(watchList));
    }
  }

  /// display the watch list movies in the watch list screen.
  Future<void> displayWatchList(Movie movie) async {
    if (isInWatchList(movie)) {
      watchList.removeWhere((m) => m.id == movie.id);
    } else {
      watchList.add(movie);
    }
    await _savedMovies.saveMovies(watchList);
    final updatedList = List<Movie>.from(watchList);

    if (updatedList.isEmpty) {
      emit(WatchListEmpty());
    } else {
      emit(WatchListLoaded(updatedList));
    }
  }

  bool isInWatchList(Movie movie) {
    return watchList.any((element) => element.id == movie.id);
  }
}
