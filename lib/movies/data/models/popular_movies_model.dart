import 'package:movies_app/movies/data/models/movie.dart';

class PopularMoviesModel {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  PopularMoviesModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) {
    return PopularMoviesModel(
      page: json['page'],
      results: (json['results'] as List)
          .map((item) => Movie.fromJson(item))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
