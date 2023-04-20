class PopularModel {
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  PopularModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> map) {
    return PopularModel(
        id: map['id'],
        backdropPath: map['backdropPath'],
        originalLanguage: map['originalLanguage'],
        originalTitle: map['originalTitle'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'],
        releaseDate: map['releaseDate'],
        title: map['title'],
        video: map['video'],
        voteAverage: (map['vote_average'] is int)
            ? (map['vote_average'] as int).toDouble()
            : map['vote_average'],
        voteCount: map['voteCount']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
