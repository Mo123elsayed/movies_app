import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/search_screen_cubit/search_screen_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
    
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
                contentPadding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
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
          SizedBox(height: 20),
          Expanded(
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
                      style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                    ),
                  );
                }
                if (state is SearchScreenEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/search-icon.svg",
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          "We Are Sorry,We Can Not Find The Movie :(",
                          style: TextStyle(
                            color: AppColor.white,
                            fontFamily: "Sora",
                          ),
                        ),
                        Text(
                          "Find your movie by Type title,categories,years, etc",
                          style: TextStyle(
                            fontFamily: "Sora",
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is SearchScreenSuccess) {
                  return ListView.builder(
                    itemCount: state.movieDetails.results.length,
                    itemBuilder: (context, index) {
                      final searchedMovie = state.movieDetails.results[index];
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
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    searchedMovie.title,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Sora',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                buildRowDetails(
                                  childern: [
                                    Icon(
                                      Icons.star_border_rounded,
                                      color: Colors.amberAccent,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${searchedMovie.voteAverage}",
                                      style: TextStyle(
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                // buildRowDetails(
                                //   childern: [
                                //     Icon(Icons.movie_creation_outlined),
                                //     SizedBox(width: 4),
                                //     Text("${searchedMovie.status}"),
                                //   ],
                                // ),
                                // buildRowDetails(
                                //   childern: [
                                //     Icon(Icons.access_time_rounded),
                                //     SizedBox(width: 4),
                                //     Text("${searchedMovie.runtime}"),
                                //   ],
                                // ),
                              ],
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
