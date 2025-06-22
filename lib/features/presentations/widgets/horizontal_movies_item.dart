import 'package:flutter/material.dart';
import 'package:movies_app/features/presentations/ui_screens/movie_details.dart';

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
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height * 0.3,
          ),
        ),
      ),
    );
  }
}
