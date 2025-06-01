import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_project/Auth/api_service.dart';
import 'package:hackathon_project/models/Providers/themeprovider.dart';
import 'package:hackathon_project/screens/splashscreen.dart';
import 'package:hackathon_project/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider()..initialize(),
        child: const Wrapper(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeProvider()..initialize(),
        child: const Splashscreen(),
      ),
    ],
    child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        theme: ThemeProvider.lightTheme,
        darkTheme: ThemeProvider.darkTheme,
        themeMode: themeProvider.themeMode,
        debugShowCheckedModeBanner: false,
        home: const Splashscreen(),
      );
    }),
  ));
}
