import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/movie_detail_screen.dart';
import 'package:streamit_flutter/screens/signin.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

import '../main.dart';

class WatchlistFragment extends StatefulWidget {
  static String tag = '/WatchlistFragment';

  @override
  WatchlistFragmentState createState() => WatchlistFragmentState();
}

class WatchlistFragmentState extends State<WatchlistFragment> {
  int userId = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    userId = await getInt(USER_ID);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Watchlist', showBack: false, color: Theme.of(context).cardColor, textColor: Colors.white),
      body: FutureBuilder<MovieResponse>(
        future: getWatchList(),
        builder: (_, snap) {
          if (snap.hasData) {
            if (snap.data.data.isEmpty) {
              return noDataWidget().center();
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snap.data.data.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                MovieData data = snap.data.data[index];

                String genre = '';

                if (data.genre != null) {
                  data.genre.forEach((element) {
                    if (genre.isNotEmpty) {
                      genre = '$genre, ${element.name.validate()}';
                    } else {
                      genre = element.name.validate();
                    }
                  });
                }

                return Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: context.width() * 0.3,
                        height: 120,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: spacing_control_half,
                              margin: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(spacing_control_half)),
                              child: commonCacheImageWidget(data.image.validate(), width: context.width() * 0.3, height: 120, fit: BoxFit.cover),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.rectangle, borderRadius: radius(4)),
                              padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                              margin: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                              child: Text(data.censor_rating.validate(), style: primaryTextStyle(size: 10, color: Colors.white)),
                            ).visible(data.censor_rating.validate().isNotEmpty),
                          ],
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                itemTitle(context, data.title).expand(),
                                Icon(Icons.bookmark).paddingAll(2).onTap(() {
                                  if (!mIsLoggedIn) {
                                    SignInScreen().launch(context);
                                    return;
                                  }
                                  Map req = {
                                    'post_id': data.id.validate(),
                                    'user_id': userId,
                                  };

                                  /*snap.data.data.remove(data);
                                  setState(() {});*/

                                  toast('Please wait');
                                  watchlistMovie(req).then((value) {
                                    setState(() {});
                                  }).catchError((e) {
                                    toast(e.toString());
                                  });
                                }),
                              ],
                            ),
                            itemSubTitle(context, "2019", fontsize: 12),
                            //itemSubTitle(context, '${buildLikeCountText(data.likes.validate())}', fontsize: 12),
                            2.height,
                            itemSubTitle(context, genre, colorThird: true, fontsize: ts_medium).visible(genre.isNotEmpty),
                          ],
                        ),
                      )
                    ],
                  ),
                ).onTap(() {
                  MovieDetailScreen(movie: data).launch(context);
                });
              },
            );
          } else {
            return snapWidgetHelper(
              snap,
              loadingWidget: Loader().withSize(height: 40, width: 40).center(),
              errorWidget: Text(errorMessage, style: boldTextStyle(color: Colors.white)).center(),
            );
          }
        },
      ),
    );
  }
}
