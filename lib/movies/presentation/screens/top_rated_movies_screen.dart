import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/data/models/top_rated_movies_model.dart';
import 'package:movies_app/movies/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';

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
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 6 / 9,
            ),
            itemCount: state
                .topRatedMovies
                .results
                .length, // Replace with the actual number of items
            itemBuilder: (context, index) {
              return Card(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 200,
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${state.topRatedMovies.results[index].posterPath}',
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
                              size: 15,
                            ),
                            Text(
                              "${state.topRatedMovies.results[index].voteAverage}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
              // return SizedBox.shrink();
            },
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
