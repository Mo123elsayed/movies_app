part of 'upcoming_cubit.dart';

sealed class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingLoading extends UpcomingState {}

final class UpcomingFailure extends UpcomingState {
  final String messageError;
  const UpcomingFailure(this.messageError);
}

final class UpcomingSuccess extends UpcomingState {
  final List<Movie> upcomingMoviesModel;
  const UpcomingSuccess(this.upcomingMoviesModel);
}
