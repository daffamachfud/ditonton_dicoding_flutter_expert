import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
            builder: (context, state) {
              if (state is WatchlistMoviesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistMoviesHasData) {
                final movies = state.result;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: movies.length,
                );
              } else if (state is WatchlistMoviesEmpty) {
                return const Center(
                  child: Text(watchlistEmpty),
                );
              } else if (state is WatchlistMoviesError) {
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
