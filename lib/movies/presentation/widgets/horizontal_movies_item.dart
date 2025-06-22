import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:movies_app/features/presentations/ui_screens/movie_details.dart';
import 'package:movies_app/movies/presentation/screens/movie_details.dart';

class HorizontalMoviesItem extends StatelessWidget {
  final String id;
  final String imageUrl;

  const HorizontalMoviesItem({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  void selectedMovie(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MovieDetails.screenRoute,
      arguments: {'id': id, 'image': imageUrl},
    );
  }

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
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
        ),
      ),
    );
  }
}
