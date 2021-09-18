part of 'movies_cubit.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  List<MovieModel>? movies;

  MoviesLoading(this.movies);

  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  List<MovieModel>? movies;

  MoviesLoaded(this.movies);

  @override
  List<Object> get props => [];
}

class MoviesError extends MoviesState {
  String? error;

  MoviesError(this.error);

  @override
  List<Object> get props => [];
}
