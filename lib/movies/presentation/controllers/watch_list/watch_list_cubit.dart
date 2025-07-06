import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/movie.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());
  List<Movie> watchList = [];

  void toggleWatchList(Movie movie) {
    if (watchList.contains(movie)) {
      watchList.remove(movie);
    } else {
      watchList.add(movie);
    }

    if (watchList.isEmpty) {
      emit(WatchListEmpty());
    } else {
      emit(WatchListLoaded(List.from(watchList)));
    }
  }
bool isInWatchList(Movie movie){
  return watchList.any((element) => element.id == movie.id);
}
}

