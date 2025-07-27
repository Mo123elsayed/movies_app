import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/data/models/movie.dart';

part 'search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  SearchScreenCubit() : super(SearchScreenInitial());
  Widget? widget;
  Future<void> getMovieDetails(String query) async {
    emit(SearchScreenLoading());
    var dio = Dio();
    try {
      dio.options.headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlhMmNlNDMxOGMwNjM4YmY5MTMzYmZlYmQ3MjVhOCIsIm5iZiI6MTc1MDU4NjU0My4yNjEsInN1YiI6IjY4NTdkNGFmYmJkOTJhYTU4YWE3YTRlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayysT1K_In1ihKttpUqPpQUg5XWOPrGPlcEhJPr4xAw",
        "Accept": "application/json",
      };

      /// encode the query to avoid any special characters
      final encodedQuery = Uri.encodeQueryComponent(query.trim());

      final response = await dio.get(
        "https://api.themoviedb.org/3/search/movie?query=$encodedQuery&include_adult=false&language=en-US&page=1",
      );
      final List<Movie> movies = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      if (movies.isEmpty) {
        emit(SearchScreenEmpty());
      } else {
        emit(SearchScreenSuccess(movies));
      }
    } catch (e) {
      emit(SearchScreenFailure(e.toString()));
      throw Exception(e.toString());
    }
    // throw Exception('Unexpected error occurred in getMovieDetails');
  }
}
