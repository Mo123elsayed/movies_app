part of 'watch_list_cubit.dart';

sealed class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

final class WatchListInitial extends WatchListState {}

final class WatchListEmpty extends WatchListState {}

final class WatchListLoaded extends WatchListState {
  final List<Movie> watchListMovies;
  const WatchListLoaded(this.watchListMovies);

  @override
  List<Object> get props => [watchListMovies];
}
