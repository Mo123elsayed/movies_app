import 'package:movies_app/movies/data/models/movie.dart';

class TopRatedMoviesModel {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  TopRatedMoviesModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRatedMoviesModel.fromJson(Map<String, dynamic> json) {
    return TopRatedMoviesModel(
      page: json['page'],
      results: List<Movie>.from(json['results'].map((x) => Movie.fromJson(x))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
