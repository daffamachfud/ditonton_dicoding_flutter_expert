import 'package:ditonton/data/models/tv/tv_show_model.dart';
import 'package:equatable/equatable.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> tvList;

  TvShowResponse({required this.tvList});

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        tvList: List<TvShowModel>.from((json["results"] as List)
            .map((x) => TvShowModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvList];
}
