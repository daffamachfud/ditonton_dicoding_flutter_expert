import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class TvShowDetailState extends Equatable {}

class TvShowDetailEmpty extends TvShowDetailState {
  @override
  List<Object?> get props => [];
}

class TvShowDetailLoading extends TvShowDetailState {
  @override
  List<Object?> get props => [];
}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  TvShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail result;

  TvShowDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
