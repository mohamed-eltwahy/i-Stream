import 'package:flutter/material.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';

class ViewAllMovieScreen extends StatefulWidget {
  static String tag = '/ViewAllMovieScreen';
  var title = "";

  ViewAllMovieScreen({this.title});

  @override
  ViewAllMovieScreenState createState() => ViewAllMovieScreenState();
}

class ViewAllMovieScreenState extends State<ViewAllMovieScreen> {
  var movieList = List<MovieData>();

  @override
  void initState() {
    super.initState();
    //movieList.addAll(getMyListMovies());
    //movieList.addAll(getContinueMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLayout(context, widget.title),
      body: AllMovieGridList(movieList),
    );
  }
}
