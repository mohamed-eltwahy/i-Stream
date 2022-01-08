import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:streamit_flutter/utils/constants.dart';

String parseHtmlString(String htmlString) {
  return parse(parse(htmlString).body.text).documentElement.text;
}

String buildLikeCountText(int like) {
  if (like > 1) {
    return '$like likes';
  } else {
    return '$like like';
  }
}

String buildCommentCountText(int comment) {
  if (comment > 1) {
    return '$comment comments';
  } else {
    return '$comment comment';
  }
}

extension SExt on String {
  int getYear() {
    return DateTime.parse(this).year;
  }

  String defaultDateFormat() {
    return DateFormat('dd').format(DateTime.parse(this));
  }
}

String getPostType(PostType postType) {
  if (postType == PostType.MOVIE) {
    return 'Movie';
  } else if (postType == PostType.TV_SHOW) {
    return 'TV Show';
  } else if (postType == PostType.EPISODE) {
    return 'Episode';
  }
  return '';
}
