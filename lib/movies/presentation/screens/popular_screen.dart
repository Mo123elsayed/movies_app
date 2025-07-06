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
          PopularFailure(state.messageError);
        }
        if (state is PopularSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 6 / 9,
            ),
            itemCount: state
                .popularMoviesModel
                .length, // Replace with the actual number of items
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: CachedNetworkImage(
                        height: 200,
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
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13,
                            ),
                            Text(
                              "${state.popularMoviesModel[index].voteAverage}",
                              style: TextStyle(
                                color: Colors.white,
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
              );
              // return SizedBox.shrink();
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
