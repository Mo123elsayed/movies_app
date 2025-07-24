import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/data/models/movies_details.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/watch_list/watch_list_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class WatchListScreen extends StatelessWidget {
  // const WatchListScreen({super.key});
  static const screenRoute = '/watch-list';

  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: AppColor.navy,
        iconTheme: IconThemeData(color: AppColor.white),
        title: Text(
          'Watch List',
          style: TextStyle(
            color: AppColor.white,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<WatchListCubit, WatchListState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is WatchListEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/watchlist-icon.svg",
                    height: 85,
                    width: 85,
                  ),
                  Text(
                    "There is no movie Yet!",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 20,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Find your movie by Type title, categories, years, etc",
                    style: TextStyle(
                      color: AppColor.lightGrey,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          if (state is WatchListLoaded) {
            return ListView.builder(
              itemCount: state.watchListMovies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: InkWell(
                    onTap: () {
                      // Navigate to movie details screen
                      Navigator.of(context).pushNamed(
                        MovieDetailsScreen.screenRoute,
                        arguments: state.watchListMovies[index],
                      );
                    },
                    child: Row(
                      spacing: 20,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500${state.watchListMovies[index].posterPath}",
                            fit: BoxFit.cover,
                            height: 190,
                            width: 110,
                          ),
                        ),

                        BlocProvider(
                          create: (context) => MovieDetailsCubit()
                            ..getMovieDetails(state.watchListMovies[index].id),
                          child: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is MovieDetailsFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.errorMessage),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is MovieDetailsSuccess) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      height: 100,
                                      child: Text(
                                        state.movieDetails.title,
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontFamily: "Sora",
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 5,
                                      children: [
                                        buildDetailsRow(
                                          state,
                                          index,
                                          children: [
                                            Icon(
                                              Icons.star_border_rounded,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              "${state.movieDetails.voteAverage.toStringAsFixed(1)}",
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontFamily: "Sora",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ],
                                        ),
                                        buildDetailsRow(
                                          state,
                                          index,
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              color: AppColor.lightGrey,
                                            ),
                                            Text(
                                              state.movieDetails.runtime
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontFamily: "Sora",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        buildDetailsRow(
                                          state,
                                          index,
                                          children: [
                                            Icon(
                                              Icons.movie_creation_rounded,
                                              color: Colors.grey.shade700,
                                            ),
                                            Text(
                                              state.movieDetails.genres[0].name,
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontFamily: "Sora",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        buildDetailsRow(
                                          state,
                                          index,
                                          children: [
                                            Icon(
                                              Icons.calendar_month_rounded,
                                              color: AppColor.lightGrey,
                                            ),
                                            Text(
                                              state
                                                  .movieDetails
                                                  .originalLanguage,
                                              style: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontFamily: "Sora",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
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
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              "Unknown Error Occur",
              style: TextStyle(
                fontFamily: "Sora",
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailsRow(
    MovieDetailsSuccess state,
    int index, {
    List<Widget>? children,
  }) {
    return Row(
      spacing: 5,
      // mainAxisSize: MainAxisSize.min, // العناصر تبدأ من الشمال
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: children ?? [],
    );
  }
}
