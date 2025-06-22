import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/most_rated_movies_model.dart';

part 'most_top_rated_state.dart';

class MostTopRatedCubit extends Cubit<MostTopRatedState> {
  MostTopRatedCubit() : super(MostTopRatedState.initial());

Future<TopRatedMoviesModel> getTopRatedMovies() async {
    emit(MostTopRatedState.loading());
    try {
      // Simulate a network call
      await Future.delayed(Duration(seconds: 2));
      // Here you would typically fetch data from an API or database
      var dio = Dio();
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzE3ODcxZGNkMTVjZDhlNTVmOGExNDIwNjBjZTc0MCIsIm5iZiI6MTc1MDMwOTQyMy4xMzQsInN1YiI6IjY4NTM5YTJmYTljOTQ2Mjc4ZTk1NTkyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1DmYJmrWlxNfgr9JAo4edy2GuyH0PEhSB4Qg9ennojc",
        "accept": "application/json",
      };
      var response = await dio.get(
        "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200",
      );
      emit(MostTopRatedStateSuccess(TopRatedMoviesModel.fromJson(response.data)));
    } catch (e) {
      emit(MostTopRatedStateFailure(e.toString()));
      rethrow;
    }
    throw DioException(
      requestOptions: RequestOptions(
        path:
            "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200",
      ),
      error: MostTopRatedStateFailure("there is an error happened"),
    );
  }
}
