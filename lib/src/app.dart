import 'package:bloc_architect/src/ui/movie_details.dart';
import 'package:bloc_architect/src/ui/movie_list.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => MyWidget(),
        "/details": (context) => MovieDetails()
      },
      theme: ThemeData.dark().copyWith(splashColor: Colors.blueGrey),
    );
  }
}
