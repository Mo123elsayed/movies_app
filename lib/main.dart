import 'package:flutter/material.dart';
import 'package:movies_app/movies/presentation/screens/bottom_bar.dart';
import 'package:movies_app/movies/presentation/screens/movie_details.dart';
import 'package:movies_app/movies/presentation/screens/watch_list_screen.dart';

void main() {
  runApp(const MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: IntroScreen(),
      routes: {
        '/': (context) => BottomBar(),
        MovieDetails.screenRoute: (context) => MovieDetails(),
        WatchListScreen.screenRoute: (context) => WatchListScreen(),
      },
    );
  }
}
