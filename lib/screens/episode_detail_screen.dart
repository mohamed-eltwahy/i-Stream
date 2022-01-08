import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/models/MovieDetailResponse.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/MovieFileWidget.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/MovieURLWidget.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/images.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class EpisodeDetailScreen extends StatefulWidget {
  static String tag = '/EpisodeDetailScreen';
  final String title;
  final Episode episode;
  final List<Episode> episodes;

  EpisodeDetailScreen({this.title, this.episode, this.episodes});

  @override
  EpisodeDetailScreenState createState() => EpisodeDetailScreenState();
}

class EpisodeDetailScreenState extends State<EpisodeDetailScreen> with WidgetsBindingObserver {
  var isLoaded = false;

  var actors = List<MovieData>();
  var isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget actorsList = Container(
      height: width * 0.32,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            return Container(
              width: width * 0.18,
              margin: EdgeInsets.only(left: spacing_standard_new),
              child: Column(
                children: <Widget>[
                  InkWell(
                    radius: width * 0.1,
                    child: CircleAvatar(
                      radius: width * 0.09,
                      backgroundImage: actors[index].image.validate() != null ? AssetImage(actors[index].image.validate()) : AssetImage(ic_profile),
                    ),
                    onTap: () {},
                  ),
                  text(
                    context,
                    actors[index].title,
                    textColor: Theme.of(context).textTheme.headline6.color,
                    fontFamily: font_medium,
                    maxLine: 2,
                    isCentered: true,
                  ).paddingOnly(left: spacing_control, right: spacing_control)
                ],
              ),
            );
          }),
    );

    Widget buttons = Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(child: IconButton(icon: Icon(Icons.thumb_up, size: 24), onPressed: () {})),
        Expanded(child: IconButton(icon: Icon(Icons.playlist_add, size: 24), onPressed: () {})),
        Expanded(child: IconButton(icon: Icon(Icons.share, size: 24), onPressed: () {})),
      ],
    );

    Widget episodesList = Container(
      height: ((width / 2) - 36) * (2.5 / 4) + 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.episodes.length,
          padding: EdgeInsets.only(left: spacing_standard, right: spacing_standard_new),
          itemBuilder: (context, index) {
            Episode episode = widget.episodes[index];

            return Container(
              margin: EdgeInsets.only(left: spacing_standard),
              width: (width / 2) - 36,
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 4 / 2.5,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: spacing_control_half,
                          margin: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(spacing_control)),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              commonCacheImageWidget(episode.image.validate(),width: double.infinity,height: double.infinity,fit: BoxFit.cover),
                              Container(
                                decoration: boxDecoration(context, bgColor: Colors.white.withOpacity(0.8)),
                                padding: EdgeInsets.only(left: spacing_control, right: spacing_control),
                                child: text(context, "EPISODE " + (index + 1).toString(), fontSize: 10, textColor: Colors.black, fontFamily: font_medium),
                              ).paddingAll(spacing_control)
                            ],
                          ),
                        ),
                      ),
                    ),
                    8.height,
                    //text(context, "Episode " + (index + 1).toString(), textColor: Theme.of(context).textTheme.headline6.color, fontSize: ts_normal).paddingTop(spacing_control_half),
                    itemSubTitle(context, "${episode.episode_number.validate()} , ${episode.release_date.validate()}", fontsize: ts_medium),
                  ],
                ),
                onTap: () {},
                radius: spacing_control,
              ),
            );
          }),
    );

    return SafeArea(
      child: Scaffold(
        body: mounted
            ? FutureBuilder<MovieDetailResponse>(
                future: episodeDetail(widget.episode.id),
                builder: (_, snap) {
                  if (snap.hasData) {
                    //
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            //Center(child: moviePoster),
                            if (widget.episode.embed_content.validate().isNotEmpty) EmbedWidget(widget.episode.embed_content.validate()).center(),

                            if (widget.episode.episode_choice.validate() == episodeChoiceURL)
                              MovieURLWidget(widget.episode.url_link.validate())
                            else if (widget.episode.episode_choice.validate() == episodeChoiceEmbed)
                              EmbedWidget(widget.episode.embed_content.validate()).center()
                            else if (widget.episode.episode_choice.validate() == episodeChoiceFile)
                              MovieFileWidget(widget.episode.episode_file.validate())
                            else
                              commonCacheImageWidget(widget.episode.image.validate(),fit: BoxFit.cover).visible(!isLoaded),
                            if (isSnapshotLoading(snap, checkHasData: true)) Loader().center(),
                            Positioned(child: BackButton().paddingAll(12), top: 0, left: 0),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: headingText(context, widget.title)),
                                IconButton(
                                  icon: Icon(!isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up),
                                  onPressed: () {
                                    isExpanded = !isExpanded;
                                    setState(() {});
                                  },
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ).paddingOnly(left: spacing_standard_new, right: spacing_control_half),
                            itemSubTitle(context, "${widget.episode.episode_number.validate()}, ${widget.episode.release_date.validate()}").paddingOnly(left: spacing_standard_new, right: spacing_standard_new),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                itemSubTitle(context, widget.episode.excerpt.validate()),
                                8.height,
                                Row(
                                  children: [
                                    itemSubTitle(context, 'Run time:'),
                                    8.width,
                                    itemTitle(context, widget.episode.run_time.validate()),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new).visible(isExpanded),
                            Divider(thickness: 1, height: 1).paddingTop(spacing_standard),
                            headingWidViewAll(context, "Episodes", callback: () {
                              finish(context);
                            }).paddingAll(spacing_standard_new),
                            episodesList,
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            : SizedBox(),
      ),
    );
  }
}
