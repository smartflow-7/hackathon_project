import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/Authenticate.dart';
import 'package:hackathon_project/models/Providers/api_service.dart';
//import 'package:hackathon_project/components/apptheme.dart';
//import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:hackathon_project/screens/main_screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  static const route = '/wrapper';
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var themecolor = Theme.of(context).colorScheme;
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<AuthProvider>(
      builder: (context, user, _) {
        print(user.token);
        if (user.isLoading) {
          return Scaffold(
              backgroundColor: themecolor.surface,
              body: Center(
                  child: CircularProgressIndicator(
                color: themecolor.primary,
              )));
        }
        if (user.token != null) {
          return const Home();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
