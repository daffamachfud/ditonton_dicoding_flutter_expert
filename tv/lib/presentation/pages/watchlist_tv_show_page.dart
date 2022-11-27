import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class WatchlistTvShowPage extends StatefulWidget {
  static const routeName = '/watchlist_tv';

  const WatchlistTvShowPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowPageState createState() => _WatchlistTvShowPageState();
}

class _WatchlistTvShowPageState extends State<WatchlistTvShowPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvShowsBloc>().add(OnWatchlistTvShowsCalled());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvShowsBloc>().add(OnWatchlistTvShowsCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Shows'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistTvShowsBloc, WatchlistTvShowsState>(
            builder: (context, state) {
              if (state is WatchlistTvShowsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistTvShowsHasData) {
                final tvShows = state.result;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvShow = tvShows[index];
                    return TvShowCard(tvShow);
                  },
                  itemCount: tvShows.length,
                );
              } else if (state is WatchlistTvShowsEmpty) {
                return const Center(
                  child: Text(watchlistEmpty),
                );
              } else if (state is WatchlistTvShowsError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text("Failed"),
                );
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
