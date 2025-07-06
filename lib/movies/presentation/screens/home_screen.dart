import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_data.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/data/models/movie.dart';
import 'package:movies_app/movies/presentation/controllers/now_playing_cubit/cubit/now_playing_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/popular_cubit/popular_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/movies/presentation/screens/now_playing_screen.dart';
import 'package:movies_app/movies/presentation/screens/popular_screen.dart';
import 'package:movies_app/movies/presentation/screens/top_rated_movies_screen.dart';
import 'package:movies_app/movies/presentation/screens/upcoming_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const screenRoute = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String searchText = '';
List moviesUrl = [
  'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
  'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
  'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
  'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpcomingCubit()..getUpComingMovies()),
        BlocProvider(
          create: (context) => NowPlayingCubit()..getNowPlayingMovies(),
        ),
        BlocProvider(create: (context) => TopRatedCubit()..getTopRatedMovies()),
        BlocProvider(create: (context) => PopularCubit()..getPopularMovies()),
      ],
      child: DefaultTabController(
        length: titleBar.length,
        child: Scaffold(
          backgroundColor: Color(0xFF242A32),
          appBar: AppBar(
            backgroundColor: AppColor.navy,
            title: Text(
              'What do you want to watch?',
              style: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Sora",
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),

                /// develop a search bar
                child: TextField(
                  // focusNode: focusNode,
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

              /// make a horizontal scrollable list
              BlocProvider(
                create: (context) => UpcomingCubit()..getUpComingMovies(),
                child: BlocConsumer<UpcomingCubit, UpcomingState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is NowPlayingLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColor.white),
                      );
                    } else if (state is UpcomingFailure) {
                      return Center(
                        child: Text(
                          'Error: ${state.messageError}}',
                          style: TextStyle(color: AppColor.white),
                        ),
                      );
                    } else if (state is UpcomingSuccess) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Stack(
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.upcomingMoviesModel.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    final movie =
                                        state.upcomingMoviesModel[index];
                                    Navigator.pushNamed(
                                      context,
                                      MovieDetailsScreen.screenRoute,
                                      arguments: movie,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w500${state.upcomingMoviesModel[index].posterPath}",
                                            fit: BoxFit.cover,
                                            height: 200,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -10,
                                          left: 0,
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              // color: Colors.redAccent,
                                              fontSize: 96,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: AppColor.navy,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -10,
                                          left: 0,
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                              // color: Colors.redAccent,
                                              fontSize: 96,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..color = Colors.blueAccent
                                                ..strokeWidth = 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    // Always return a widget
                    return SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 15),

              TabBar(
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                indicatorColor: AppColor.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColor.white,
                unselectedLabelColor: Colors.grey.shade700,
                tabs: titleBar
                    .map(
                      (name) => Tab(
                        child: Text(
                          name.title,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    NowPlayingScreen(),
                    UpcomingScreen(),
                    TopRatedMoviesScreen(),
                    PopularScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
