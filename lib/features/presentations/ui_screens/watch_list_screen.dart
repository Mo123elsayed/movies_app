import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_color.dart';

class WatchListScreen extends StatelessWidget {
  // const WatchListScreen({super.key});
  static const screenRoute = '/watch-list';

  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.white),
        title: Text('Watch List'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(child: Text("You have no Movies yet!")),
    );
  }
}
