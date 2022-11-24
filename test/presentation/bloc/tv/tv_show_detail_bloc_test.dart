import 'package:ditonton/domain/usecases/tv/get_tv_show_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:mockito/annotations.dart';

import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late MockGetTvShowDetail mockGetTvShowDetail;
  late TvShowDetailBloc tvShowDetailBloc;

  const testId = 1;
}
