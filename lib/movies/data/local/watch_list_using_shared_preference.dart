import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/movie.dart';

class WatchListUsingSharedPreference {
  /// This class is responsible for saving and loading the watch list movies
  /// the key used to store the watch list in SharedPreferences is '_key'.
  static const String _key = 'watch_list';

  Future<void> saveMovies(List<Movie> movies) async {
    /// get the instance of SharedPreferences, to save the data in the phone.
    final prefs = await SharedPreferences.getInstance();

    /// Convert the list of movies to a JSON string and save it.
    /// This is done by mapping each movie to its JSON representation.
    final movie = movies.map((movie) => movie.toJson()).toList();
    prefs.setString(_key, jsonEncode(movie));
  }

  /// Load the watch list movies from SharedPreferences to display them in the watch list screen.
  /// If there are no movies saved, it returns an empty list.
  Future<List<Movie>> loadMovies() async {
    /// Get the instance of SharedPreferences to retrieve the data.
    final prefs = await SharedPreferences.getInstance();

    /// Get the JSON string from SharedPreferences using the key '_key', to retrieve the saved movies.
    final jsonString = prefs.getString(_key);

    /// If the JSON string is null, it means there are no movies saved, so return an empty list.
    if (jsonString == null) return [];

    /// Decode the JSON string to a list of movies.,to convert the JSON string back to a list of Movie objects.
    final loadedMovies = jsonDecode(jsonString) as List;

    /// Map the loaded movies to Movie objects and return it as a list,to convert the loaded JSON data back to a list of Movie objects,to displayed in the watch list screen.
    return loadedMovies.map((e) => Movie.fromJson(e)).toList();
  }
}
