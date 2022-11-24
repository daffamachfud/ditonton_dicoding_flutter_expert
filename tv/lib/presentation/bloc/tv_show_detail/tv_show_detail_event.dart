import 'package:equatable/equatable.dart';

abstract class TvShowDetailEvent extends Equatable {}

class OnTvShowDetailCalled extends TvShowDetailEvent {
  final int id;

  OnTvShowDetailCalled(this.id);

  @override
  List<Object> get props => [];
}