import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/screens/movieDetailComponents/MovieGridWidget.dart';
import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/constants.dart';

class ViewAllMoviesScreen extends StatefulWidget {
  static String tag = '/ViewAllMoviesScreen';
  int index;
  String type;

  ViewAllMoviesScreen(this.index, this.type);

  @override
  ViewAllMoviesScreenState createState() => ViewAllMoviesScreenState();
}

class ViewAllMoviesScreenState extends State<ViewAllMoviesScreen> {
  List<MovieData> movies = List<MovieData>();
  ScrollController scrollController = ScrollController();

  int page = 1;

  bool isLoading = true;
  bool loadMore = true;
  bool hasError = false;

  String title = '';

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (loadMore) {
          page++;
          isLoading = true;

          setState(() {});

          init();
        }
      }
    });
  }

  Future<void> init() async {
    viewAll(widget.index, widget.type ?? dashboardTypeHome, page: page).then((value) {
      isLoading = false;

      if (page == 1) movies.clear();
      loadMore = value.data.length == postPerPage;

      title = value.title.validate();

      movies.addAll(value.data);

      setState(() {});
    }).catchError((e) {
      log(e);
      isLoading = false;
      hasError = true;

      toast(e.toString());
      setState(() {});
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title, color: Theme.of(context).cardColor, textColor: Colors.white, textSize: 22),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: MovieGridList(movies),
              controller: scrollController,
            ),
            Loader().withSize(height: 40, width: 40).center().visible(isLoading),
            noDataWidget().center().visible(!isLoading && movies.isEmpty && !hasError),
            Text(errorSomethingWentWrong, style: boldTextStyle(color: Colors.white)).center().visible(hasError),
          ],
        ),
      ),
    );
  }
}
