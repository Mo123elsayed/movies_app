import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/search_screen_cubit/search_screen_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/watch_list/watch_list_cubit.dart';
import 'package:movies_app/movies/presentation/screens/bottom_bar.dart';
import 'package:movies_app/movies/presentation/screens/home_screen.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/movies/presentation/screens/search_screen.dart';
import 'package:movies_app/movies/presentation/screens/watch_list_screen.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => WatchListCubit(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
          create: (context) => SearchScreenCubit(),
          child: BottomBar(),
        ),
        MovieDetailsScreen.screenRoute: (context) => MovieDetailsScreen(),
        WatchListScreen.screenRoute: (context) => WatchListScreen(),
        HomeScreen.screenRoute: (context) => HomeScreen(),
        SearchScreen.screenRoute: (context) => SearchScreen(),
      },
    );
  }
}
