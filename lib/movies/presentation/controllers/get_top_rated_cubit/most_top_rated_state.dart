part of 'most_top_rated_cubit.dart';

// Make sure to import or define BaseStatus and its loading value.
// Example definition (replace with your actual implementation):
enum BaseStatus { loading, success, failure }

final class MostTopRatedState extends Equatable {
  final BaseStatus status;

  const MostTopRatedState({required this.status});

  factory MostTopRatedState.initial() =>
      MostTopRatedState(status: BaseStatus.loading);

  // MostTopRatedState copyWith({BaseStatus? status}) {
  //   return MostTopRatedState(status: status ?? this.status);
  // }

  @override
  List<Object> get props => [status];

  static MostTopRatedState loading() {
    return const MostTopRatedStateLoading();
  }
}

final class MostTopRatedStateLoading extends MostTopRatedState {
  const MostTopRatedStateLoading() : super(status: BaseStatus.loading);
}

final class MostTopRatedStateSuccess extends MostTopRatedState {
  final TopRatedMoviesModel topRatedMovies;
  const MostTopRatedStateSuccess(this.topRatedMovies)
      : super(status: BaseStatus.success);
}
final class MostTopRatedStateFailure extends MostTopRatedState {
  final String message;
  const MostTopRatedStateFailure(this.message) : super(status: BaseStatus.failure);
}


