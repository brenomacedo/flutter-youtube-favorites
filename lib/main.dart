import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_faviritess/blocs/favorite_bloc.dart';
import 'package:youtube_faviritess/blocs/videos_bloc.dart';
import 'package:youtube_faviritess/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'Youtube Favorites',
          home: Home()
        ),
      )
    );
  }
}