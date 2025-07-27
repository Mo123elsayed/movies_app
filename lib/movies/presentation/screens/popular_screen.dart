import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/popular_cubit/popular_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<PopularCubit, PopularState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PopularLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.white),
          );
        }
        if (state is PopularFailure) {
          return Center(
            child: Text(
              'Error: ${state.messageError}',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontFamily: "Sora",
              ),
            ),
          );
        }
        if (state is PopularSuccess) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                childAspectRatio: 6 / 12,
              ),
              itemCount: state.popularMoviesModel.length,
              itemBuilder: (context, index) {
                final selectedMovie = state.popularMoviesModel[index];
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
                              height: screenSize.height * 0.22,
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${state.popularMoviesModel[index].posterPath}',
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
                                  Icon(
                                    Icons.star,
                                    color: AppColor.yellow,
                                    size: 13,
                                  ),
                                  Text(
                                    state.popularMoviesModel[index].voteAverage
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                      color: AppColor.yellow,
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
                        state.popularMoviesModel[index].title,
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
        return SizedBox.shrink();
      },
    );
  }
}
