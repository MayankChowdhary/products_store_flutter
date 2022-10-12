import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/flunkey_model.dart';
import '../../../data/repositories/flunkey_repository.dart';


part 'flunkey_list_event.dart';

part 'flunkey_list_state.dart';

class SongBloc extends Bloc<SongListEvent, SongListState> {
  final ProductRepository _songRepository;

  SongBloc(this._songRepository) : super(SongLoadingState()) {
    on<LoadSongListEvent>((event, emit) async {
      emit(SongLoadingState());
      try {
        debugPrint("Fetching Song List...");
        final song = await _songRepository.getSongs();
        emit(SongLoadedState(song));
      } catch (e) {
        debugPrint("Printing Error: $e");
        emit(SongErrorState(e.toString()));
      }
    });
  }
}
