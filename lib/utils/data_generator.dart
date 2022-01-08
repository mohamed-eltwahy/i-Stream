import 'package:streamit_flutter/models/MovieData.dart';
import 'package:streamit_flutter/models/response.dart';

List<HomeSlider> getSliders() {
  var list = List<HomeSlider>();
  list.add(HomeSlider(slideImage: "assets/items/home/slider1.jpg", title: "Bushland", isHD: true));
  list.add(HomeSlider(slideImage: "assets/items/home/slider1_.jpg", title: "The Jungle Book", isHD: false));

  list.add(HomeSlider(slideImage: "assets/items/home/slider2_.jpg", title: "Sail Coaster", isHD: false));
  list.add(HomeSlider(slideImage: "assets/items/home/slider3.jpg", title: "The Army", isHD: true));

  return list;
}

List<HomeSlider> getMovieSliders() {
  var list = List<HomeSlider>();
  list.add(HomeSlider(slideImage: "assets/items/movies/05.jpg", title: "Jumbo Queeen", isHD: true));
  list.add(HomeSlider(slideImage: "assets/items/movies/06.jpg", title: "The Lost Journey", isHD: false));

  list.add(HomeSlider(slideImage: "assets/items/movies/07.jpg", title: "Open Dead Shot", isHD: false));
  list.add(HomeSlider(slideImage: "assets/items/movies/08.jpg", title: "Unknown Land", isHD: true));

  return list;
}

List<HomeSlider> getShowsSliders() {
  var list = List<HomeSlider>();
  list.add(HomeSlider(slideImage: "assets/items/shows/01.jpg", title: "The Hero Camp", isHD: true));
  list.add(HomeSlider(slideImage: "assets/items/shows/02.jpg", title: "The Apartment", isHD: false));

  list.add(HomeSlider(slideImage: "assets/items/shows/03.jpg", title: "The Marshal King", isHD: false));

  return list;
}

List<Movie> getUpcomingMovie() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/home/upcoming/01.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/home/upcoming/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/upcoming/03.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/home/upcoming/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/upcoming/05.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/home/upcoming/06.jpg", isHD: true));

  return list;
}

List<Movie> getPopularShows() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/shows/01.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/03.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/05.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/06.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/07.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/08.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/09.jpg", isHD: true));

  return list;
}

List<Movie> getInternationalShows() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/shows/05.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/06.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/08.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/07.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/09.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/01.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/shows/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/shows/03.jpg", isHD: true));

  return list;
}

List<Movie> getBollywoodBlockBusters() {
  return getUpcomingMovie();
}

List<Movie> getTrendingOnMovie() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/home/trending/01.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/trending/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/trending/03.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/trending/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/trending/05.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/trending/06.jpg", isHD: false));

  return list;
}

List<Movie> getMadeForYouMovie() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/home/suggested/01.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/suggested/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/suggested/03.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/suggested/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/home/suggested/05.jpg", isHD: false));

  return list;
}

List<Movie> getTop10() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/movies/01.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/movies/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/movies/03.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/movies/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/movies/05.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/movies/06.jpg", isHD: false));

  return list;
}

List<Movie> getEpisodes() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/episodes/01.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/episodes/02.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/03.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/episodes/04.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/05.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/06.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/07.jpg", isHD: true));
  list.add(Movie(slideImage: "assets/items/episodes/08.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/09.jpg", isHD: false));
  list.add(Movie(slideImage: "assets/items/episodes/10.jpg", isHD: false));

  return list;
}

List<MovieData> getContinueMovies() {
  var list = List<MovieData>();
  list.add(MovieData(image: "assets/items/home/favorite/01.jpg", title: "Champions in the Ring"));
  list.add(MovieData(image: "assets/items/home/favorite/02.jpg", title: "Last Race"));
  list.add(MovieData(image: "assets/items/home/favorite/03.jpg", title: "Boop Bitty"));
  list.add(MovieData(image: "assets/items/home/favorite/04.jpg", title: "Dino Land"));
  list.add(MovieData(image: "assets/items/home/favorite/05.jpg", title: "Jaction Action"));

  return list;
}

List<MovieData> getMyListMovies() {
  var list = List<MovieData>();
  list.add(MovieData(title: "Hubby Cubby"));
  list.add(MovieData(title: "The Illusion"));
  list.add(MovieData(title: "Last Race"));
  list.add(MovieData(title: "Dino land"));

  return list;
}

List<Movie> getDownloadedMovies() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/movies/08.jpg", isHD: false, percent: 0.5, title: "Unknown Land"));
  list.add(Movie(slideImage: "assets/items/shows/03.jpg", isHD: true, percent: 0.4, title: "Arrival 1999"));
  list.add(Movie(slideImage: "assets/items/shows/04.jpg", isHD: false, percent: 0.9, title: "Night Mare"));

  return list;
}

List<FAQ> getFaq() {
  var list = List<FAQ>();
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));

  return list;
}

List<Movie> getActors() {
  var list = List<Movie>();
  list.add(Movie(slideImage: "assets/items/actors/1.jpg", isHD: true, percent: 0.2, title: "Rajiv Kapoor"));
  list.add(Movie(slideImage: "assets/items/actors/01.jpg", isHD: false, percent: 0.8, title: "John doe"));
  list.add(Movie(slideImage: "assets/items/actors/02.jpg", isHD: true, percent: 0.4, title: "Alice Denial"));
  list.add(Movie(slideImage: "assets/items/actors/03.jpg", isHD: false, percent: 0.5, title: "John Vinaas"));
  list.add(Movie(slideImage: "assets/items/actors/04.jpg", isHD: false, percent: 0.1, title: "Alexender Cinah"));
  list.add(Movie(slideImage: "assets/items/actors/05.jpg", isHD: false, percent: 0.9, title: "Tim Svages"));

  return list;
}
