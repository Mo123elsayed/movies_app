class SearchResponse {
  final int page;
  final List<SearchedMovie> results;
  final int totalPages;
  final int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => SearchedMovie.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

class SearchedMovie {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;

  SearchedMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });

  factory SearchedMovie.fromJson(Map<String, dynamic> json) {
    return SearchedMovie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
