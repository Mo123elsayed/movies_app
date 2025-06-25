import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_data.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/now_playing_cubit/cubit/now_playing_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';
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
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpcomingCubit()..getUpComingMovies()),
        BlocProvider(
          create: (context) => NowPlayingCubit()..getNowPlayingMovies(),
        ),
        BlocProvider(create: (context) => TopRatedCubit()..getTopRatedMovies()),
      ],
      child: DefaultTabController(
        length: titleBar.length,
        child: Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: AppColor.black,
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
                child: TextField(
                  focusNode: focusNode,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moviesUrl.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          moviesUrl[index],
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    );
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
                            fontFamily: 'Sora',
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
