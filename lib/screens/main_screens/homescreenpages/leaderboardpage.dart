import 'package:flutter/material.dart';
import 'package:hackathon_project/models/Providers/leaderboardprovider.dart';
import 'package:provider/provider.dart';

class Leaderboardpage extends StatefulWidget {
  const Leaderboardpage({super.key});

  @override
  State<Leaderboardpage> createState() => _LeaderboardpageState();
}

class _LeaderboardpageState extends State<Leaderboardpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaderboardProvider>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width;
    // double height = size.height;
    /// print('Leaderboard Page Width: $width, Height: $height');

    return Consumer<LeaderboardProvider>(builder: (context, provider, child) {
      switch (provider.state) {
        case LeaderboardState.loading:
          return Container(
            color: Colors.green,
          );
        case LeaderboardState.loaded:
          print(provider.users[0].name);
          return Container(
            color: Colors.blue,
          );
        // TODO: Handle this case.
        case LeaderboardState.error:
          return Container(
            color: Colors.red,
          );
        // TODO: Handle this case.
        case LeaderboardState.refreshing:
          return Container(
            color: Colors.yellow,
          );
        // TODO: Handle this case.
      }
    });
  }
}
