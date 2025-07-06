// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:movies_app/features/presentations/ui_screens/movie_details.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class HorizontalMoviesItem extends StatelessWidget {
  final String id;
  final String imageUrl;

  HorizontalMoviesItem({super.key, required this.id, required this.imageUrl});

  void selectedMovie(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MovieDetailsScreen.screenRoute,
      arguments: {'id': id, 'image': imageUrl},
    );
  }

  List moviesUrl = [
    'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
    'https://image.tmdb.org/t/p/w500/4xgk2b1c5d3a7e1f8b2d3a7e1f8b2.jpg',
    'https://image.tmdb.org/t/p/w500/2Xk3L4m5N6O7P8Q9R0S1T2U3V4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => selectedMovie(context),
      child: Container(
        width: screenSize.width * 0.45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
