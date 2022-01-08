import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MovieURLWidget extends StatefulWidget {
  static String tag = '/MovieURLWidget';

  final String url;

  MovieURLWidget(this.url);

  @override
  MovieURLWidgetState createState() => MovieURLWidgetState();
}

class MovieURLWidgetState extends State<MovieURLWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(widget.url, aspectRatio: 16 / 9, js: true),
    );
  }
}
