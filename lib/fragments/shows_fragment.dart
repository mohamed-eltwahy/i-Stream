import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/models/response.dart';
import 'package:streamit_flutter/screens/view_all_movies_screen.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/data_generator.dart';
import 'package:streamit_flutter/utils/resources/size.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/ItemHorizontalList.dart';

class ShowsCategoryFragment extends StatefulWidget {
  static String tag = '/ShowsCategoryFragment';
  var type;

  ShowsCategoryFragment({this.type});

  @override
  ShowsCategoryFragmentState createState() => ShowsCategoryFragmentState();
}

class ShowsCategoryFragmentState extends State<ShowsCategoryFragment> {
  var mSliderList = List<HomeSlider>();
  var mMovieList = List<MovieData>();
  var mCinemaMovieList = List<MovieData>();
  var mContinueList = List<MovieData>();
  var mTrendingMuviList = List<MovieData>();
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
      mSliderList.addAll(getShowsSliders());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget slider = mSliderList.isNotEmpty ? HomeSliderWidget(mSliderList) : Container();

    Widget popularMovieList = mMovieList.isNotEmpty ? ItemHorizontalList(mMovieList, isMovie: false) : Container();

    Widget trendingMovieList = mTrendingMuviList.isNotEmpty ? ItemHorizontalList(mTrendingMuviList, isMovie: false) : Container();

    Widget newCinemaList = mCinemaMovieList.isNotEmpty ? ItemHorizontalList(mCinemaMovieList, isMovie: false) : Container();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                slider.paddingTop(spacing_standard_new),
                headingWidViewAll(context, 'Popular Shows', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Popular Shows')));
                }).paddingAll(spacing_standard_new),
                popularMovieList,
                headingWidViewAll(context, 'Best Of International Shows', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Best Of International Shows')));
                }).paddingAll(spacing_standard_new),
                newCinemaList,
                headingWidViewAll(context, 'Shows We Recommend', callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: 'Shows We Recommend')));
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
