import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:mockito/annotations.dart';

import 'now_playing_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late NowPlayingTvShowsBloc nowPlayingTvShowsBloc;

  const testId = 1;
}
