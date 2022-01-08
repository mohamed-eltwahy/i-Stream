import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/models/response.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/ItemHorizontalList.dart';
import 'package:streamit_flutter/screens/view_all_movies_screen.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/data_generator.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class MovieCategoryFragment extends StatefulWidget {
  static String tag = '/MovieCategoryFragment';
  var type;

  MovieCategoryFragment({this.type});

  @override
  MovieCategoryFragmentState createState() => MovieCategoryFragmentState();
}

class MovieCategoryFragmentState extends State<MovieCategoryFragment> {
  var mSliderList = List<HomeSlider>();
  var mBlockbustersLisr = List<MovieData>();
  var mRecommended = List<MovieData>();
  var mContinueList = List<MovieData>();
  var mBestMovies = List<MovieData>();
  var mMadeForYouList = List<MovieData>();
  bool isLoading = false;

  showLoading(bool show) {
    setState(() {
      isLoading = show;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      mSliderList.addAll(getMovieSliders());
      //mBlockbustersLisr.addAll(getUpcomingMovie());
      //mRecommended.addAll(getTop10());
      //mBestMovies.addAll(getContinueMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    var slider = mSliderList.isNotEmpty ? HomeSliderWidget(mSliderList, isMovie: true) : Container();

    var blockBustersList = mBlockbustersLisr.isNotEmpty ? ItemHorizontalList(mBlockbustersLisr, isMovie: true) : Container();
    var trendingMovieList = mBestMovies.isNotEmpty ? ItemHorizontalList(mBestMovies, isMovie: true) : Container();
    var newCinemaList = mRecommended.isNotEmpty ? ItemHorizontalList(mRecommended, isMovie: true) : Container();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                slider.paddingTop(spacing_standard_new),
                headingWidViewAll(context, 'Bollywood Blockbusters', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Bollywood Blockbusters')));
                }).paddingAll(spacing_standard_new),
                blockBustersList,
                headingWidViewAll(context, 'Best Bengali Movies', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Best Bengali Movies')));
                }).paddingAll(spacing_standard_new),
                newCinemaList,
                headingWidViewAll(context, 'Movies We Recommend', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Movies We Recommend')));
                }).paddingAll(spacing_standard_new),
                trendingMovieList.paddingBottom(spacing_standard_new)
              ],
            ),
          ),
          Center(child: loadingWidgetMaker().visible(isLoading))
        ],
      ),
    );
  }
}
