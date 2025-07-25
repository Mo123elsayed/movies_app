part of 'popular_cubit.dart';

sealed class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularFailure extends PopularState {
  final String messageError;
  const PopularFailure(this.messageError);
}

final class PopularSuccess extends PopularState {
  final List<Movie> popularMoviesModel;
  const PopularSuccess(this.popularMoviesModel);
}
