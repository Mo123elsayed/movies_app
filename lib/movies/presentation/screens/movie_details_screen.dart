import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_data.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/watch_list/watch_list_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/movie_details.dart';

import '../../data/models/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const screenRoute = '/movie-details';
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedMovie = ModalRoute.of(context)?.settings.arguments as Movie;
    final screenSize = MediaQuery.of(context).size;

    // final selectedMovie = List<Movie>.firstWhere((movie)=> movie.id == movieId);

    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        actions: [
          BlocConsumer<WatchListCubit, WatchListState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = context.read<WatchListCubit>();
              final isInWatchList = cubit.isInWatchList(selectedMovie);
              return IconButton(
                onPressed: () => cubit.displayWatchList(selectedMovie),
                icon: Icon(
                  isInWatchList
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: isInWatchList ? Colors.white : Colors.white,
                ),
              );
            },
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
        backgroundColor: AppColor.navy,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// cover image of the movie
                  CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${selectedMovie.backdropPath}",
                    width: screenSize.width,
                    height: screenSize.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: screenSize.height * 0.12),

                  // the rest of the page content
                ],
              ),

              /// movie booster
              Positioned(
                top: screenSize.height * 0.22,
                left: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${selectedMovie.posterPath}",
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
                          fontFamily: "Sora",
                          fontSize: 25,
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
          BlocProvider(
            create: (context) =>
                MovieDetailsCubit()..getMovieDetails(selectedMovie.id),
            child: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is MovieDetailsFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: TextStyle(
                          fontFamily: "Sora",
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MovieDetailsSuccess) {
                  return Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildMovieMetaDataRow(
                            icon: Icons.calendar_month_outlined,
                            movieData: selectedMovie.releaseDate,
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.grey.shade400,
                          ),
                          buildMovieMetaDataRow(
                            icon: Icons.access_time_rounded,
                            movieData:
                                state.movieDetails.runtime.toString() +
                                " minutes",
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.grey.shade400,
                          ),
                          buildMovieMetaDataRow(
                            icon: Icons.movie_creation_outlined,
                            movieData: state.movieDetails.genres[0].name,
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(height: 20),
          DefaultTabController(
            length: detailsTitleBar.length,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.only(left: 10),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.grey.shade700,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppColor.white,
                    unselectedLabelColor: Colors.grey.shade700,
                    tabs: detailsTitleBar
                        .map(
                          (name) => Tab(
                            child: Text(
                              name.title,
                              style: const TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildTabBarContent(selectedMovie.overview),
                        buildTabBarContent(selectedMovie.overview),
                        buildTabBarContent(selectedMovie.overview),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Padding buildTabBarContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Text(
        content,
        style: TextStyle(fontFamily: "Sora", fontSize: 15, color: Colors.grey),
      ),
    );
  }

  Widget buildMovieMetaDataRow({IconData? icon, String? movieData}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade400),
        SizedBox(width: 10),
        Text(
          movieData.toString(),
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
