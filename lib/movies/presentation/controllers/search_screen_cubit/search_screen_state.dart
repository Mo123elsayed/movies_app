part of 'search_screen_cubit.dart';

sealed class SearchScreenState extends Equatable {
  const SearchScreenState();

  @override
  List<Object> get props => [];
}

final class SearchScreenInitial extends SearchScreenState {}
final class SearchScreenLoading extends SearchScreenState {}

final class SearchScreenFailure extends SearchScreenState {
  final String errorMessage;

  const SearchScreenFailure(this.errorMessage);
}

final class SearchScreenEmpty extends SearchScreenState {
}

final class SearchScreenSuccess extends SearchScreenState {
  final SearchResponse movieDetails;
  const SearchScreenSuccess(this.movieDetails);
}
