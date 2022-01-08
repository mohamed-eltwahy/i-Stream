import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/common.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

import '../movie_detail_screen.dart';

class ItemHorizontalList extends StatelessWidget {
  var list = List<MovieData>();
  var isMovie = false;

  ItemHorizontalList(this.list, {this.isMovie = false});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        padding: EdgeInsets.only(left: spacing_standard, right: spacing_standard_new),
        itemBuilder: (context, index) {
          MovieData data = list[index];

          return Container(
            margin: EdgeInsets.only(left: spacing_standard),
            width: 250,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: spacing_control_half,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(spacing_control)),
                    child: commonCacheImageWidget(data.image.validate(), height: double.infinity, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(data.run_time.validate(), style: boldTextStyle(size: 10)),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: radius(4)),
                        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      ).visible(data.run_time.validate().isNotEmpty),
                      4.height,
                      itemTitle(context, parseHtmlString(data.title.validate()), maxLine: 2),
                      hdWidget(context).visible(data.isHD.validate()),
                    ],
                  ).paddingAll(8),
                ],
              ),
              onTap: () {
                //isMovie ? MovieDetailScreen(title: "Action", movie: data) : SeriesDetailScreen(title: "Action")));

                MovieDetailScreen(movie: data).launch(context);
              },
              radius: spacing_control,
            ),
          );
        },
      ),
    );
  }
}
