import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/videos_bloc.dart';
import 'package:youtube_favorites/delegates/data_search.dart';
import 'package:youtube_favorites/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text('0')
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
              if(result != null) BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
            );
          else
            return Container();
        },
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
      ),
    );
  }
}