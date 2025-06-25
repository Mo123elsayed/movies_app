import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/data/models/now_playing_movies_model.dart'
    hide Movie;
import 'package:movies_app/movies/data/models/upcoming_movies_model.dart';
import 'package:movies_app/movies/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text(
    //     'Upcoming Movies Screen',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 24,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
    return BlocConsumer<UpcomingCubit, UpcomingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is UpcomingLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.white),
          );
        }
        if (state is UpcomingFailure) {
          return Center(child: Text(state.mesaageError));
        }
        if (state is UpcomingSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 25.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 6 / 9,
            ),
            itemCount: state
                .upcomingMoviesModel
                .results
                .length, // Replace with the actual number of items
            itemBuilder: (context, index) {
              return Card(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${state.upcomingMoviesModel.results[index].posterPath}',
                        fit: BoxFit.cover,
                        height: 200,
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                              "${state.upcomingMoviesModel.results[index].voteAverage}",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Sora",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
              //     // return SizedBox.shrink();
            },
          );
        }
        return Center(child: Text('Unknown Error, please try again later!'));
      },
    );
  }
}
