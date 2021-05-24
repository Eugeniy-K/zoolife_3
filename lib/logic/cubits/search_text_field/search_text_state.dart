
part of 'search_text_cubit.dart';

abstract class SearchTextState extends Equatable {}


class SearchTextUpdated extends SearchTextState {
  final String searchText;

  @override
  List<Object?> get props => [searchText];

  SearchTextUpdated({required this.searchText});
}