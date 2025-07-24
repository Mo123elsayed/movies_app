import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/movies_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    var dio = Dio();
    try{
      dio.options.headers = {
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlhMmNlNDMxOGMwNjM4YmY5MTMzYmZlYmQ3MjVhOCIsIm5iZiI6MTc1MDU4NjU0My4yNjEsInN1YiI6IjY4NTdkNGFmYmJkOTJhYTU4YWE3YTRlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayysT1K_In1ihKttpUqPpQUg5XWOPrGPlcEhJPr4xAw",
        "accept": "application/json",
      };
      var response = await dio.get("https://api.themoviedb.org/3/movie/$movieId?language=en-US");
      final MovieDetails movieDetails = MovieDetails.fromJson(response.data);
      emit(MovieDetailsSuccess(movieDetails));
    } catch (e) {
      emit(MovieDetailsFailure(e.toString()));
    }
  }
}
