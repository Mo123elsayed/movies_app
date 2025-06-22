import 'package:flutter/material.dart';
import 'package:movies_app/features/presentations/ui_screens/bottom_bar.dart';
import 'package:movies_app/features/presentations/ui_screens/movie_details.dart';
import 'package:movies_app/features/presentations/ui_screens/watch_list_screen.dart';

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
        '/': (context) => IntroScreen(),
        MovieDetails.screenRoute: (context) => MovieDetails(),
        WatchListScreen.screenRoute: (context) => WatchListScreen(),
      },
    );
  }
}
