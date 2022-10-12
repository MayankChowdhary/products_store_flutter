

part of 'flunkey_list_bloc.dart';

@immutable
abstract class SongListState extends Equatable {}

class SongLoadingState extends SongListState {
  @override
  List<Object?> get props => [];
}

class SongLoadedState extends SongListState {
  final List<ProductModel> items;

  SongLoadedState(this.items);

  @override
  List<Object?> get props => [items];
}

class SongErrorState extends SongListState {
  final String error;

  SongErrorState(this.error);

  @override
  List<Object?> get props => [error];
}