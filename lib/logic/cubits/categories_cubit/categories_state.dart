import 'package:equatable/equatable.dart';
import 'package:zoolife_2/models/banner.dart';
import 'package:zoolife_2/models/product_category.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitState extends CategoriesState {}

///Категории загружаются
class CategoriesLoadingState extends CategoriesState {}

///категории загрузились
class CategoriesLoadedState extends CategoriesState {
  final List<ProductCategory> categories;
  final List<HomeBanner> banners;

  CategoriesLoadedState(this.categories, this.banners);

  @override
  List<Object> get props => [categories, banners];
}

class CategNotLoadedState extends CategoriesState {}