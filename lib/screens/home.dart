import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_faviritess/blocs/favorite_bloc.dart';
import 'package:youtube_faviritess/blocs/videos_bloc.dart';
import 'package:youtube_faviritess/delegates/data_search.dart';
import 'package:youtube_faviritess/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _bloc = BlocProvider.of<VideosBloc>(context);
    final _favBloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('images/yt.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: _favBloc.outFav,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else
                  return Container();
                
              },
            )
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) _bloc.inSearch.add(result);
            },
          )
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if(index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if(index > 0) {
                  _bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          }

          return Container();
        },
        stream: _bloc.outVideos,
        initialData: [],
      ),
      backgroundColor: Colors.black,
    );
  }
}