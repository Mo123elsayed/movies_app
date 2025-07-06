import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/movies/presentation/controllers/watch_list/watch_list_cubit.dart';

class WatchListScreen extends StatelessWidget {
  // const WatchListScreen({super.key});
  static const screenRoute = '/watch-list';

  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navy,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: AppColor.navy,
        iconTheme: IconThemeData(color: AppColor.white),
        title: Text(
          'Watch List',
          style: TextStyle(
            color: AppColor.white,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocConsumer<WatchListCubit, WatchListState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is WatchListEmpty) {
            return Center(
              child: Text(
                'No movies in watch list,yet!',
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: "Roboto",
                  fontSize: 20,
                ),
              ),
            );
          }
          if (state is WatchListLoaded) {
            return ListView.builder(
              itemCount: state.watchListMovies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Row(
                    spacing: 20,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500${state.watchListMovies[index].posterPath}",
                          fit: BoxFit.cover,
                          height: 170,
                          width: 110,
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.watchListMovies[index].title,
                            style: TextStyle(
                              color: AppColor.white,
                              fontFamily: "Sora",
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              buildDetailsRow(
                                state,
                                index,
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    "${state.watchListMovies[index].voteAverage}",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontFamily: "Sora",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ],
                              ),
                              buildDetailsRow(
                                state,
                                index,
                                children: [
                                  Icon(
                                    Icons.language_rounded,
                                    color: Colors.grey.shade700,
                                  ),
                                  Text(
                                    state
                                        .watchListMovies[index]
                                        .originalLanguage,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Sora",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              buildDetailsRow(
                                state,
                                index,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey.shade700,
                                  ),
                                  Text(
                                    state.watchListMovies[index].releaseDate,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontFamily: "Sora",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              "Unknown Error Occur",
              style: TextStyle(
                fontFamily: "Sora",
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailsRow(
    WatchListLoaded state,
    int index, {
    List<Widget>? children,
  }) {
    return Row(
      spacing: 5,
      // mainAxisSize: MainAxisSize.min, // العناصر تبدأ من الشمال
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: children ?? [],
    );
  }
}
