import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/movie.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());
  Future<void> getNowPlayingMovies() async {
    emit(NowPlayingLoading());
    var dio = Dio();
    try {
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlhMmNlNDMxOGMwNjM4YmY5MTMzYmZlYmQ3MjVhOCIsIm5iZiI6MTc1MDU4NjU0My4yNjEsInN1YiI6IjY4NTdkNGFmYmJkOTJhYTU4YWE3YTRlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayysT1K_In1ihKttpUqPpQUg5XWOPrGPlcEhJPr4xAw",
        "accept": "application/json",
      };
      var response = await dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1",
      );
      final List<Movie> movies = List<Movie>.from(
        response.data['results'].map((e) => Movie.fromJson(e)),
      );
      emit(NowPlayingSuccess(movies));
    } catch (e) {
      emit(NowPlayingFailure(e.toString()));
    }
  }
}
