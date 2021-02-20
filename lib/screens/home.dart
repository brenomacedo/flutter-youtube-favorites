import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/videos_bloc.dart';
import 'package:youtube_favorites/delegates/data_search.dart';
import 'package:youtube_favorites/widgets/video_tile.dart';

class Home extends StatelessWidget {

  final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();

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
              if(result != null) bloc.inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        initialData: [],
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {

                if(index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1){
                  bloc.inSearch.add(null);
                  return Container();
                } else {
                  return Container();
                }

              },
            );
          else
            return Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red)
              ),
            );
        },
        stream: bloc.outVideos,
      ),
    );
  }
}