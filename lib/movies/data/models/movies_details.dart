class MovieDetails {
  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
    /// Deserialize the movie from json data to a MovieDetails object ,because the api returns json data
  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: List<ProductionCompany>.from(
        json['production_companies'].map((x) => ProductionCompany.fromJson(x)),
      ),
      productionCountries: List<ProductionCountry>.from(
        json['production_countries'].map((x) => ProductionCountry.fromJson(x)),
      ),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: List<SpokenLanguage>.from(
        json['spoken_languages'].map((x) => SpokenLanguage.fromJson(x)),
      ),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }

    /// serialize the movie to json data,before sending it to the api to save it in the phone
  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'budget': budget,
        'genres': genres.map((x) => x.toJson()).toList(),
        'homepage': homepage,
        'id': id,
        'imdb_id': imdbId,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies': productionCompanies.map((x) => x.toJson()).toList(),
        'production_countries': productionCountries.map((x) => x.toJson()).toList(),
        'release_date': releaseDate,
        'revenue': revenue,
        'runtime': runtime,
        'spoken_languages': spokenLanguages.map((x) => x.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logoPath,
        'name': name,
        'origin_country': originCountry,
      };
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso31661,
        'name': name,
      };
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'english_name': englishName,
        'iso_639_1': iso6391,
        'name': name,
      };
}
