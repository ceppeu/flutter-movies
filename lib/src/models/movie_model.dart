class Movies {
  List<Movie> items = new List();

  Movies();
  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  double popularity;
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  String uniqueId;

  Movie({
    this.popularity,
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'] / 1;
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    releaseDate = json['release_date'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  getPosterImg() {
    if (posterPath == null)
      return 'https://icon-library.com/images/no-photo-available-icon/no-photo-available-icon-8.jpg';
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBgImg() {
    if (posterPath == null)
      return 'https://icon-library.com/images/no-photo-available-icon/no-photo-available-icon-8.jpg';
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
