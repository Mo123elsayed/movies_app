import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_color.dart';
// import 'package:movies_app/features/presentations/ui_screens/watch_list_screen.dart';
import 'package:movies_app/movies/presentation/screens/watch_list_screen.dart';

/// an introduction screen to our app
///
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

String searchText = '';

class _BottomBarState extends State<BottomBar> {
  int _screenIndex = 0;
void _selectedTab(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  /// List of Map to Navigate around the screens
  final List<Map<String, dynamic>> _screens = [
    {'title': 'Intro Screen', 'screen': BottomBar()},
    // {'title': 'Search Screen', 'screen': IntroScreen()},
    {'title': 'Watch List', 'screen': WatchListScreen()},
  ];
  @override
  Widget build(BuildContext context) {
    ///
    // final routeArgs =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>? ??
        {};

    ///
    final movieId = routeArgs['id'];
    final movieImageUrl = routeArgs['imageUrl'];

    return Scaffold(
      backgroundColor: AppColor.black,

      body: _screens[_screenIndex]['screen'],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          elevation: 4,
          onTap: _selectedTab,
          currentIndex: _screenIndex,
          backgroundColor: Colors.grey[800],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search_rounded),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              label: 'Watch List',
            ),
          ],
        ),
      ),
    );
  }
}
