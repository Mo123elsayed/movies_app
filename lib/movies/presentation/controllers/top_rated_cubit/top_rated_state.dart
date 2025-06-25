part of 'top_rated_cubit.dart';

// Make sure to import or define BaseStatus and its loading value.
// Example definition (replace with your actual implementation):
enum BaseStatus { loading, success, failure }

final class TopRatedState extends Equatable {
  final BaseStatus status;

  const TopRatedState({required this.status});

  factory TopRatedState.initial() => TopRatedState(status: BaseStatus.loading);

  // MostTopRatedState copyWith({BaseStatus? status}) {
  //   return MostTopRatedState(status: status ?? this.status);
  // }

  @override
  List<Object> get props => [status];

  static TopRatedState loading() {
    return const TopRatedStateLoading();
  }
}

final class TopRatedStateLoading extends TopRatedState {
  const TopRatedStateLoading() : super(status: BaseStatus.loading);
}

final class TopRatedStateSuccess extends TopRatedState {
  final TopRatedMoviesModel topRatedMovies;
   const TopRatedStateSuccess(this.topRatedMovies)
    : super(status: BaseStatus.success);
}

final class TopRatedStateFailure extends TopRatedState {
  final String message;
  const TopRatedStateFailure(this.message) : super(status: BaseStatus.failure);
}
