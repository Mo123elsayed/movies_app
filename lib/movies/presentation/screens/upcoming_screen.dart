import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});
  static const screenRoute = "/upcoming";
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
          return Center(
            child: Center(
              child: Text(
                state.messageError,
                style: TextStyle(color: AppColor.white),
              ),
            ),
          );
        }
        if (state is UpcomingSuccess) {
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
                  .upcomingMoviesModel
                  .length, // Replace with the actual number of items
              itemBuilder: (context, index) {
                final selectedMovie = state.upcomingMoviesModel[index];
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
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${state.upcomingMoviesModel[index].posterPath}',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.20,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                                spacing: 2,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 13,
                                  ),
                                  Text(
                                    state.upcomingMoviesModel[index].voteAverage.toStringAsFixed(1),
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
                      SizedBox(height: 5),
                      Text(
                        state.upcomingMoviesModel[index].title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                );
                //     // return SizedBox.shrink();
              },
            ),
          );
        }
        return Center(child: Text('Unknown Error, please try again later!'));
      },
    );
  }
}
