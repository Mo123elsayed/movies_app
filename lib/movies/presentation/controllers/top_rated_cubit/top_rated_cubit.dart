import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/movie.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(TopRatedState.initial());

  Future<void> getTopRatedMovies() async {
    var dio = Dio();
    emit(TopRatedStateLoading());
    try {
      /// fetch data from an API or database
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzE3ODcxZGNkMTVjZDhlNTVmOGExNDIwNjBjZTc0MCIsIm5iZiI6MTc1MDMwOTQyMy4xMzQsInN1YiI6IjY4NTM5YTJmYTljOTQ2Mjc4ZTk1NTkyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1DmYJmrWlxNfgr9JAo4edy2GuyH0PEhSB4Qg9ennojc",
        "accept": "application/json",
      };
      var response = await dio.get(
        "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200",
      );
      // final topRatedMovies = TopRatedMoviesModel.fromJson(response.data);
      final List<Movie> movies = List<Movie>.from(
        response.data['results'].map((e) => Movie.fromJson(e)),
      );
      emit(TopRatedStateSuccess(movies));
    } catch (e) {
      emit(TopRatedStateFailure(e.toString()));
    }
  }
}
