import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_data.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/get_top_rated_cubit/most_top_rated_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/horizontal_movies_item.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

String searchText = '';

class _IntroScreenState extends State<IntroScreen> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, String>? ??
    //     {};

    ///
    // final movieId = routeArgs['id'];
    // final movieImageUrl = routeArgs['imageUrl'];

    return BlocProvider(
      create: (context) => MostTopRatedCubit(),
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
          child: Column(
            children: [
              TextField(
                focusNode: FocusNode(),
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
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: horizontalMovies.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: HorizontalMoviesItem(
                        id: horizontalMovies[index].id,
                        imageUrl: horizontalMovies[index].imageUrl,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),

              ///
              DefaultTabController(
                length: titleBar.length,
                child: TabBar(
                  physics: BouncingScrollPhysics(),
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
                            style: TextStyle(fontFamily: 'Sora', fontSize: 15),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
