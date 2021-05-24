import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_text_state.dart';

class SearchTextCubit extends Cubit<SearchTextState> {
  SearchTextCubit() : super(SearchTextUpdated(searchText: ''));

  void searchTextChanged(String value) {
    emit(SearchTextUpdated(searchText: value,));
  }
}