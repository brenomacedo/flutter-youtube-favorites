import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_faviritess/api.dart';
import 'package:youtube_faviritess/blocs/favorite_bloc.dart';
import 'package:youtube_faviritess/models/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v) {
              return InkWell(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text(v.title, style: TextStyle(color: Colors.white), maxLines: 2),
                    )
                  ],
                ),
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id);
                },
                onLongPress: () {
                  _bloc.toggleFavorite(v);
                },
              );
            }).toList(),
          );
        },
        stream: _bloc.outFav,
      ),
    );
  }
}