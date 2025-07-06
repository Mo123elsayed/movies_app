import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/movie.dart';
import 'package:movies_app/movies/data/models/upcoming_movies_model.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());

  Future<UpcomingMoviesModel> getUpComingMovies() async {
    var dio = Dio();
    emit(UpcomingLoading());
    try {
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlhMmNlNDMxOGMwNjM4YmY5MTMzYmZlYmQ3MjVhOCIsIm5iZiI6MTc1MDU4NjU0My4yNjEsInN1YiI6IjY4NTdkNGFmYmJkOTJhYTU4YWE3YTRlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayysT1K_In1ihKttpUqPpQUg5XWOPrGPlcEhJPr4xAw",
        "accept": "application/json",
      };
      final response = await dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1",
      );
      // final upcomingMovies = UpcomingMoviesModel.fromJson(response.data);
      final List<Movie> movies = List<Movie>.from(
        response.data['results'].map((e) => Movie.fromJson(e)),
      );
      emit(UpcomingSuccess(movies));
      return movies as UpcomingMoviesModel;
    } catch (e) {
      // emit(UpcomingFailure(e.toString()));
      throw Exception(e.toString());
    }
  }
}
