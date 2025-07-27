import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class TopRatedMoviesScreen extends StatefulWidget {
  const TopRatedMoviesScreen({super.key});
  static const String routeName = '/top-rated-movies';

  @override
  State<TopRatedMoviesScreen> createState() => _TopRatedMoviesScreenState();
}

class _TopRatedMoviesScreenState extends State<TopRatedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedCubit, TopRatedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TopRatedStateLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.white),
          );
        }
        if (state is TopRatedStateFailure) {
          TopRatedStateFailure(state.message);
        }
        if (state is TopRatedStateSuccess) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 25.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 6 / 11,
              ),
              itemCount: state
                  .topRatedMovies
                  .length, // Replace with the actual number of items
              itemBuilder: (context, index) {
                final selectedMovie = state.topRatedMovies[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: AppColor.white,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      MovieDetailsScreen.screenRoute,
                      arguments: selectedMovie,
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: MediaQuery.of(context).size.height * 0.20,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${state.topRatedMovies[index].posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 2, bottom: 3),
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 13,
                                  ),
                                  Text(
                                    state.topRatedMovies[index].voteAverage.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sora",
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        state.topRatedMovies[index].title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 12,
                          fontFamily: "Sora",
                        ),
                      ),
                    ],
                  ),
                );
                // return SizedBox.shrink();
              },
            ),
          );
        }
        return Center(
          child: Text(
            "Unknown Error,please try again later!",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 15,
              fontFamily: "Sora",
            ),
          ),
        );
      },
    );
  }
}
