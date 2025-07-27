import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/movie.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());

  /// get now playing movies, load more movies if loadMore is true
  int totalPages = 1;
  int currentPage = 1;
  bool isLoadingMore = false;
  List<Movie> allMovies = [];
  Future<void> getNowPlayingMovies({bool loadMore = false}) async {
    // if (loadMore) {
    //   if (isLoadingMore) return;
    //   isLoadingMore = true;
    //   // stop loading more, if the current page is the last page
    //   if (currentPage >= totalPages) {
    //     isLoadingMore = false;
    //     return;
    //   }
    //   currentPage++;
    // } else {
    //   currentPage = 1;
    //   allMovies.clear();
    // }
    var dio = Dio();
    try {
      emit(NowPlayingLoading());
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlhMmNlNDMxOGMwNjM4YmY5MTMzYmZlYmQ3MjVhOCIsIm5iZiI6MTc1MDU4NjU0My4yNjEsInN1YiI6IjY4NTdkNGFmYmJkOTJhYTU4YWE3YTRlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayysT1K_In1ihKttpUqPpQUg5XWOPrGPlcEhJPr4xAw",
        "accept": "application/json",
      };
      var response = await dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=$currentPage",
      );
      totalPages = response.data['total_pages'];
      // print(" ====================== the total pages : $totalPages");
      // print(" ====================== the current pages : $currentPage");
      final List<Movie> movies = List<Movie>.from(
        response.data['results'].map((e) => Movie.fromJson(e)),
      );
      allMovies.addAll(movies);
      emit(NowPlayingSuccess(movies));
    } catch (e) {
      emit(NowPlayingFailure(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }
}
