part of 'now_playing_cubit.dart';

sealed class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

final class NowPlayingInitial extends NowPlayingState {}
final class NowPlayingLoading extends NowPlayingState {}
final class NowPlayingFailure extends NowPlayingState {
  final String errorMessage;
   const NowPlayingFailure( this.errorMessage);
}
final class NowPlayingSuccess extends NowPlayingState {
  final NowPlayingMoviesModel nowPlayingMovies;

  const NowPlayingSuccess(this.nowPlayingMovies);
}

