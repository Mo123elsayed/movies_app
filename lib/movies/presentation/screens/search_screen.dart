import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/search_screen_cubit/search_screen_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String screenRoute = "/searchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop('/'),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.white),
        ),
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(color: AppColor.white, fontFamily: "Sora"),
        ),
        backgroundColor: AppColor.navy,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),

            /// develop a search bar
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                if (query.trim().isNotEmpty) {
                  context.read<SearchScreenCubit>().getMovieDetails(query);
                }
              },
              style: TextStyle(
                color: AppColor.white,
                decoration: TextDecoration.none,
                fontFamily: 'Sora',
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                  borderSide: BorderSide(color: AppColor.white),
                ),
                hintText: 'Search',
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Expanded(
            flex: 1,
            child: BlocConsumer<SearchScreenCubit, SearchScreenState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is SearchScreenLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.white),
                  );
                }
                if (state is SearchScreenFailure) {
                  return Center(
                    child: Text(
                      "Error: ${state.errorMessage}",
                      style: TextStyle(
                        color: AppColor.white,
                        fontFamily: 'Sora',
                      ),
                    ),
                  );
                }
                if (state is SearchScreenEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/searchIcon.svg",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          "We Are Sorry,We Can Not Find The Movie :(",
                          style: TextStyle(
                            color: AppColor.white,
                            fontFamily: "Sora",
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Find your movie by Type title,categories,years, etc",
                          style: TextStyle(
                            fontFamily: "Sora",
                            color: AppColor.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is SearchScreenSuccess) {
                  return ListView.builder(
                    itemCount: state.movieDetails.length,
                    itemBuilder: (context, index) {
                      final searchedMovie = state.movieDetails[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w500${searchedMovie.posterPath}",
                                height: 150,
                                width: 100,
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.03),
                            BlocProvider(
                              create: (context) => MovieDetailsCubit()
                                ..getMovieDetails(state.movieDetails[index].id),
                              child:
                                  BlocConsumer<
                                    MovieDetailsCubit,
                                    MovieDetailsState
                                  >(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      if (state is MovieDetailsSuccess) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: screenSize.width * 0.4,
                                              child: Text(
                                                state.movieDetails.title,
                                                style: TextStyle(
                                                  color: AppColor.white,
                                                  fontFamily: 'Sora',
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.01,
                                            ),
                                            buildRowDetails(
                                              childern: [
                                                Icon(
                                                  Icons.star_border_rounded,
                                                  color: Colors.amberAccent,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  state.movieDetails.voteAverage
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                    color: Colors.amberAccent,
                                                    fontFamily: "Sora",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            buildRowDetails(
                                              childern: [
                                                Icon(
                                                  Icons.movie_creation_outlined,
                                                  color: AppColor.lightGrey,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  state
                                                      .movieDetails
                                                      .genres[0]
                                                      .name,
                                                  style: TextStyle(
                                                    color: AppColor.lightGrey,
                                                    fontFamily: "Sora",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            buildRowDetails(
                                              childern: [
                                                Icon(
                                                  Icons.access_time_rounded,
                                                  color: AppColor.lightGrey,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${state.movieDetails.runtime} Minutes",
                                                  style: TextStyle(
                                                    color: AppColor.lightGrey,
                                                    fontFamily: "Sora",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            buildRowDetails(
                                              childern: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: AppColor.lightGrey,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  state
                                                      .movieDetails
                                                      .releaseDate,
                                                  style: TextStyle(
                                                    color: AppColor.lightGrey,
                                                    fontFamily: "Sora",
                                                    fontSize: 15,
                                                  ),
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
                      );
                    },
                  );
                }
                return Center();
              },
            ),
          ),
        ],
      ),
    );
  }

  Row buildRowDetails({List<Widget>? childern}) {
    return Row(children: childern!);
  }
}
