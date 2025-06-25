part of 'upcoming_cubit.dart';

sealed class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingLoading extends UpcomingState {}

final class UpcomingFailure extends UpcomingState {
  final String mesaageError;
  const UpcomingFailure(this.mesaageError);
}

final class UpcomingSuccess extends UpcomingState {
  final UpcomingMoviesModel upcomingMoviesModel;
  UpcomingSuccess(this.upcomingMoviesModel);
}
