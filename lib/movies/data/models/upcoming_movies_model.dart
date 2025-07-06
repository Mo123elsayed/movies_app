import 'package:movies_app/movies/data/models/movie.dart';

class UpcomingMoviesModel {
  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  UpcomingMoviesModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingMoviesModel.fromJson(Map<String, dynamic> json) {
    return UpcomingMoviesModel(
      dates: Dates.fromJson(json['dates']),
      page: json['page'],
      results: List<Movie>.from(json['results'].map((x) => Movie.fromJson(x))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(maximum: json['maximum'], minimum: json['minimum']);
  }
}

