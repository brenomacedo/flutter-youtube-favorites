import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favorites/api.dart';
import 'package:youtube_favorites/models/video.dart';

class VideosBloc implements BlocBase {

  Api api;
  List<Video> videos;

  final StreamController _videosController = StreamController();

  final StreamController _searchController = StreamController();

  Stream get outVideos {
    return _videosController.stream;
  }

  Sink get inSearch {
    return _searchController.sink;
  }

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);

  }

  void _search(String search) async {

    videos = await api.search(search);

    print(videos);

  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

}