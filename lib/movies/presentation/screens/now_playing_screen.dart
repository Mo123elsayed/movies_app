import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/now_playing_cubit/cubit/now_playing_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NowPlayingCubit, NowPlayingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.white),
          );
        }
        if (state is NowPlayingFailure) {
          return Center(
            child: Text('${NowPlayingFailure(state.errorMessage)}'),
          );
        }
        if (state is NowPlayingSuccess) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                childAspectRatio: 6 / 12,
              ),
              itemCount: state
                  .nowPlayingMovies
                  .length, // Replace with the actual number of items
              itemBuilder: (context, index) {
                final selectedMovie = state.nowPlayingMovies[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.screenRoute,
                      arguments: selectedMovie,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        // color: AppColor.primaryColor,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${state.nowPlayingMovies[index].posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                alignment: Alignment.bottomRight,
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
                                      '${state.nowPlayingMovies[index].voteAverage}',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        fontFamily: "Sora",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        state.nowPlayingMovies[index].title,
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
            "Unknown Error, please try again later!",
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
