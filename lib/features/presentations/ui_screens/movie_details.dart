import 'package:flutter/material.dart';
import 'package:movies_app/app_data.dart';
import 'package:movies_app/core/theme/app_color.dart';

class MovieDetails extends StatelessWidget {
  static const screenRoute = '/movie-details';

  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final routeArgs = args is Map<String, String> ? args : <String, String>{};

    final movieId = routeArgs['id'] ?? '';
    final selectedMovie = horizontalMovies.firstWhere(
      (movie) => movie.id == movieId,
      orElse: () => horizontalMovies.first,
    );

    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border_outlined),
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        iconTheme: IconThemeData(color: AppColor.white),
        title: Text(
          'Details',
          style: TextStyle(
            color: AppColor.white,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColor.black,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// cover image of the movie
              Image.asset(
                selectedMovie.imageUrl,
                width: screenSize.width,
                height: screenSize.height * 0.4,
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenSize.height * 0.12),

              // the rest of the page content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "About Movie",
                    //   style: TextStyle(
                    //     color: AppColor.white,
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: 'Sora',
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // Text(
                    //   "No description available.",
                    //   style: TextStyle(
                    //     color: Colors.white70,
                    //     fontSize: 14,
                    //     fontFamily: 'Sora',
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    // أضف تفاصيل تانية زي التقييم، النوع، التاريخ إلخ هنا
                  ],
                ),
              ),
            ],
          ),

          /// movie booster
          Positioned(
            top: screenSize.height * 0.3,
            left: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    selectedMovie.imageUrl,
                    height: screenSize.height * 0.2,
                    width: screenSize.width * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: Text(
                    selectedMovie.title,
                    style: TextStyle(
                      // fontFamily: "Roboto",
                      fontSize: 20,
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
