import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

void main() {
  final tTvShowModel = TvShowModel(
      backdropPath: "backdropPath",
      firstAirDate: "2021-10-12",
      genreIds: const [1, 2, 3, 4],
      id: 1,
      name: "name",
      originCountry: const ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  final tTvShow = TvShow(
      backdropPath: "backdropPath",
      firstAirDate: "2021-10-12",
      genreIds: const [1, 2, 3, 4],
      id: 1,
      name: "name",
      originCountry: const ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Tv show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
