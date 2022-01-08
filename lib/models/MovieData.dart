import 'package:streamit_flutter/utils/constants.dart';

class MovieResponse {
  List<MovieData> data;
  List<Season> seasons;

  MovieResponse({
    this.data,
    this.seasons,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      seasons: json['seasons'] != null ? (json['seasons'] as List).map((i) => Season.fromJson(i)).toList() : null,
      data: json['data'] != null ? (json['data'] as List).map((i) => MovieData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MovieData {
  String description;
  String excerpt;
  List<Genre> genre;
  int id;
  String image;
  List<Tag> tag;
  String title;
  bool isHD;
  String logo;
  String avg_rating;
  String award_description;
  String censor_rating;
  String embed_content;
  String movie_choice;
  String publish_date;
  String publish_date_gmt;
  String release_date;
  String run_time;
  String trailer_link;
  String url_link;
  String movie_file;
  List<Visibility> visibility;
  bool isInWatchList;
  bool isLiked;
  int likes;
  String attachment;
  String award_image;

  //Local
  PostType postType;

  MovieData({
    this.avg_rating,
    this.award_description,
    this.censor_rating,
    this.description,
    this.embed_content,
    this.excerpt,
    this.genre,
    this.id,
    this.image,
    this.logo,
    this.tag,
    this.title,
    this.movie_choice,
    this.publish_date,
    this.publish_date_gmt,
    this.release_date,
    this.run_time,
    this.trailer_link,
    this.url_link,
    this.visibility,
    this.isInWatchList,
    this.isLiked,
    this.likes,
    this.postType,
    this.movie_file,
    this.attachment,
    this.award_image,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      avg_rating: json['avg_rating'],
      award_description: json['award_description'],
      censor_rating: json['censor_rating'],
      description: json['description'],
      excerpt: json['excerpt'],
      embed_content: json['embed_content'],
      genre: json['genre'] != null ? (json['genre'] as List).map((i) => Genre.fromJson(i)).toList() : null,
      id: json['id'],
      image: json['image'],
      tag: json['tag'] != null ? (json['tag'] as List).map((i) => Tag.fromJson(i)).toList() : null,
      title: json['title'],
      logo: json['logo'],
      likes: json['likes'],
      movie_choice: json['movie_choice'],
      publish_date: json['publish_date'],
      publish_date_gmt: json['publish_date_gmt'],
      release_date: json['release_date'],
      run_time: json['run_time'],
      trailer_link: json['trailer_link'],
      url_link: json['url_link'],
      isInWatchList: json['is_watchlist'],
      movie_file: json['movie_file'],
      award_image: json['award_image'],
      isLiked: json['is_liked'] != null
          ? json['is_liked'] == postLike
              ? true
              : false
          : false,
      visibility: json['visibility'] != null ? (json['visibility'] as List).map((i) => Visibility.fromJson(i)).toList() : null,
      postType: json['post_type'] != null
          ? json['post_type'] == 'movie'
              ? PostType.MOVIE
              : json['post_type'] == 'episode'
                  ? PostType.EPISODE
                  : json['post_type'] == 'tv_show'
                      ? PostType.TV_SHOW
                      : PostType.NONE
          : PostType.NONE,
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_file'] = this.movie_file;
    data['description'] = this.description;
    data['excerpt'] = this.excerpt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['avg_rating'] = this.avg_rating;
    data['award_description'] = this.award_description;
    data['censor_rating'] = this.censor_rating;
    data['embed_content'] = this.embed_content;
    data['movie_choice'] = this.movie_choice;
    data['publish_date'] = this.publish_date;
    data['publish_date_gmt'] = this.publish_date_gmt;
    data['release_date'] = this.release_date;
    data['run_time'] = this.run_time;
    data['trailer_link'] = this.trailer_link;
    data['url_link'] = this.url_link;
    data['logo'] = this.logo;
    data['is_watchlist'] = this.isInWatchList;
    data['is_liked'] = this.isLiked;
    data['likes'] = this.likes;
    data['postType'] = this.postType;
    if (this.genre != null) {
      data['genre'] = this.genre.map((v) => v.toJson()).toList();
    }
    if (this.tag != null) {
      data['tag'] = this.tag.map((v) => v.toJson()).toList();
    }
    if (this.visibility != null) {
      data['visibility'] = this.visibility.map((v) => v.toJson()).toList();
    }
    data['attachment'] = this.attachment;
    data['award_image'] = this.award_image;
    return data;
  }
}

class Genre {
  int id;
  String name;
  String slug;

  Genre({this.id, this.name, this.slug});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Tag {
  int id;
  String name;
  String slug;

  Tag({this.id, this.name, this.slug});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Visibility {
  int id;
  String name;
  String slug;

  Visibility({this.id, this.name, this.slug});

  factory Visibility.fromJson(Map<String, dynamic> json) {
    return Visibility(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Season {
  String description;
  List<Episode> episode;
  String image;
  String name;
  int position;
  String year;

  Season({this.description, this.episode, this.image, this.name, this.position, this.year});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      description: json['description'],
      episode: json['episode'] != null ? (json['episode'] as List).map((i) => Episode.fromJson(i)).toList() : null,
      image: json['image'],
      name: json['name'],
      position: json['position'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['image'] = this.image;
    data['name'] = this.name;
    data['position'] = this.position;
    data['year'] = this.year;
    if (this.episode != null) {
      data['episode'] = this.episode.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episode {
  String description;
  String embed_content;
  String episode_choice;
  String episode_number;
  String excerpt;
  int id;
  String image;
  bool is_featured;
  String is_liked;
  bool is_watchlist;
  int likes;
  String post_type;
  String release_date;
  String run_time;
  String title;
  String tv_show_id;
  String episode_file;
  String url_link;

  Episode({
    this.description,
    this.embed_content,
    this.episode_choice,
    this.episode_number,
    this.excerpt,
    this.id,
    this.image,
    this.is_featured,
    this.is_liked,
    this.is_watchlist,
    this.likes,
    this.post_type,
    this.release_date,
    this.run_time,
    this.title,
    this.tv_show_id,
    this.episode_file,
    this.url_link,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      description: json['description'],
      episode_file: json['episode_file'],
      url_link: json['url_link'],
      embed_content: json['embed_content'],
      episode_choice: json['episode_choice'],
      episode_number: json['episode_number'],
      excerpt: json['excerpt'],
      id: json['id'],
      image: json['image'],
      is_featured: json['is_featured'],
      is_liked: json['is_liked'],
      is_watchlist: json['is_watchlist'],
      likes: json['likes'],
      post_type: json['post_type'],
      release_date: json['release_date'],
      run_time: json['run_time'],
      title: json['title'],
      tv_show_id: json['tv_show_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode_file'] = this.episode_file;
    data['url_link'] = this.url_link;
    data['description'] = this.description;
    data['embed_content'] = this.embed_content;
    data['episode_choice'] = this.episode_choice;
    data['episode_number'] = this.episode_number;
    data['excerpt'] = this.excerpt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_featured'] = this.is_featured;
    data['is_liked'] = this.is_liked;
    data['is_watchlist'] = this.is_watchlist;
    data['likes'] = this.likes;
    data['post_type'] = this.post_type;
    data['release_date'] = this.release_date;
    data['run_time'] = this.run_time;
    data['title'] = this.title;
    data['tv_show_id'] = this.tv_show_id;
    return data;
  }
}
