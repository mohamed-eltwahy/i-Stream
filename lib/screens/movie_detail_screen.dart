import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/models/MovieDetailResponse.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/ItemHorizontalList.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/MovieDetailLikeWatchListWidget.dart';
import 'package:streamit_flutter/screens/view_all_movies_screen.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

import 'movieDetailComponents/MovieFileWidget.dart';
import 'movieDetailComponents/MovieURLWidget.dart';
import 'movieDetailComponents/SeasonDataWidget.dart';

class MovieDetailScreen extends StatefulWidget {
  static String tag = '/MovieDetailScreen';
  var title = "";
  MovieData movie;

  MovieDetailScreen({this.title, this.movie});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> with WidgetsBindingObserver {
  var mMovieList = List<MovieData>();
  var mMovieOriginalsList = List<MovieData>();
  var trailerVideo;

  Future future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.movie.postType == PostType.MOVIE) {
      future = movieDetail(widget.movie.id.validate());
    } else if (widget.movie.postType == PostType.TV_SHOW) {
      future = tvShowDetail(widget.movie.id.validate());
    } else if (widget.movie.postType == PostType.EPISODE) {
      future = episodeDetail(widget.movie.id.validate());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLayout(context, parseHtmlString(widget.movie.title.validate()), darkBackground: false),
      body: FutureBuilder<MovieDetailResponse>(
        future: future,
        builder: (_, snap) {
          String genre = '';

          if (snap.hasData) {
            widget.movie = snap.data.data;

            if (widget.movie.postType == PostType.TV_SHOW) {
              log(snap.data.seasons.validate().length);
            }

            if (snap.data.data.genre != null) {
              snap.data.data.genre.forEach((element) {
                if (genre.isNotEmpty) {
                  genre = '$genre • ${element.name.validate()}';
                } else {
                  genre = element.name.validate();
                }
              });
            }
          }
          return Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile && widget.movie.movie_choice.validate() == movieChoiceURL)
                        MovieURLWidget(widget.movie.url_link.validate())
                      else if (isMobile && widget.movie.movie_choice.validate() == movieChoiceEmbed)
                        EmbedWidget(widget.movie.embed_content.validate()).center()
                      else if (isMobile && widget.movie.movie_choice.validate() == movieChoiceFile)
                        MovieFileWidget(widget.movie.movie_file.validate())
                      else
                        AspectRatio(
                          child: commonCacheImageWidget(widget.movie.image.validate(), width: context.width(), fit: BoxFit.cover),
                          aspectRatio: 16 / 10,
                        ),
                      8.height,
                      headingText(context, parseHtmlString(widget.movie.title.validate()), fontSize: 20).paddingOnly(left: 8, right: 8, bottom: 8),
                      itemSubTitle(context, genre, colorThird: true, fontsize: ts_medium).paddingOnly(left: 8, right: 8, bottom: 8).visible(genre.trim().isNotEmpty),
                      if (snap.hasData)
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                8.width,
                                Container(
                                  child: Text(snap.data.data.censor_rating.validate(), style: boldTextStyle()),
                                  padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                  decoration: BoxDecoration(color: Colors.white),
                                ).visible(snap.data.data.censor_rating.validate().isNotEmpty),
                                8.width.visible(snap.data.data.censor_rating.validate().isNotEmpty),
                                itemTitle(context, snap.data.data.run_time.validate()).visible(snap.data.data.run_time.validate().isNotEmpty),
                              ],
                            ),
                            8.height.visible(snap.data.data.run_time.validate().isNotEmpty),
                          ],
                        ),
                      MoreLessText(widget.movie.excerpt.validate(), colorThird: true, fontsize: 14).paddingOnly(left: 8, right: 8, bottom: 8).visible(widget.movie.excerpt.validate().isNotEmpty),
                      MovieDetailLikeWatchListWidget(widget.movie).paddingAll(8),
                    ],
                  ).paddingAll(8),
                  if (snap.hasData && widget.movie.postType == PostType.TV_SHOW) SeasonDataWidget(snap.data.seasons.validate(), widget.movie),
                  snap.hasData
                      ? Column(
                          children: [
                            Divider(),
                            headingWidViewAll(
                              context,
                              "Recommended Movies",
                              callback: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: "Recommended Movies")));
                              },
                              showViewMore: false,
                            ).paddingOnly(left: 16, right: 16, top: 12, bottom: 16),
                            ItemHorizontalList(snap.data.recommended_movie, isMovie: false),
                            headingWidViewAll(
                              context,
                              "Upcoming Movies",
                              callback: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieScreen(title: "Upcoming Movies")));
                              },
                              showViewMore: false,
                            ).paddingOnly(left: 16, right: 16, top: 12, bottom: 16),
                            ItemHorizontalList(snap.data.upcomming_movie, isMovie: false),
                          ],
                        ).visible(snap.data.recommended_movie.validate().isNotEmpty)
                      : Loader().visible(isSnapshotLoading(snap, checkHasData: true)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
