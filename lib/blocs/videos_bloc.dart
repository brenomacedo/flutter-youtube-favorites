import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_faviritess/api.dart';
import 'package:youtube_faviritess/models/video.dart';

class VideosBloc implements BlocBase {

  Api api;

  List<Video> videos;

  final StreamController _videosController = StreamController();
  final StreamController _searchController = StreamController();

  Sink get inSearch => _searchController.sink;

  Stream get outVideos => _videosController.stream;

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