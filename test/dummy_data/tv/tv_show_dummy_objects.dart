import 'package:ditonton/data/models/genre_model.dart';

import 'package:ditonton/data/models/tv/tv_show_table.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/entities/tv/tv_show_detail.dart';

final testTvShow = TvShow(
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2352.496,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3470);

final testTvShowList = [testTvShow];

final testTvShowDetail = TvShowDetail(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: [],
    episodeRunTime: [1],
    firstAirDate: "firstAirDate",
    genres: [
      GenreModel(id: 1, name: "name"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: [""],
    lastAirDate: "lastAirDate",
    lastEpisodeToAir: [],
    name: "name",
    nextEpisodeToAir: 1,
    networks: [],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: [],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 0.0,
    posterPath: "posterPath",
    productionCompanies: [],
    productionCountries: [],
    seasons: [],
    spokenLanguages: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 0.0,
    voteCount: 1);

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
