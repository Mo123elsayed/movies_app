import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/popular_movies_model.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());

  Future<PopularMoviesModel> getPopularMovies() async{
    var dio = Dio();
    emit(PopularLoading());
    try {
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMzE3ODcxZGNkMTVjZDhlNTVmOGExNDIwNjBjZTc0MCIsIm5iZiI6MTc1MDMwOTQyMy4xMzQsInN1YiI6IjY4NTM5YTJmYTljOTQ2Mjc4ZTk1NTkyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1DmYJmrWlxNfgr9JAo4edy2GuyH0PEhSB4Qg9ennojc",
        "accept": "application/json",
      };
      var response = await dio.get(
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1",
      );
      final PopularMoviesModel popularMovies = PopularMoviesModel.fromJson(
        response.data,
      );
      emit(PopularSuccess(popularMovies));
      return popularMovies;
    } catch (e) {
      emit(PopularFailure(e.toString()));
      throw DioException;
    }
  }
}
