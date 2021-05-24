import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:zoolife_2/constants.dart';
import 'package:zoolife_2/models/banner.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/repositories/catalog_repository.dart';
import 'package:zoolife_2/services/hive_service.dart';

import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CatalogRepository catalogRepository;
  final Connectivity connectivity;
  final HiveService hiveService = HiveService();

  StreamSubscription? connectivityStreamSubscription;

  CategoriesCubit({required this.catalogRepository, required this.connectivity})
      : super(CategoriesInitState()) {
    monitorInternetConnection();
    emitCategoriesState();
  }

  ///Получение категорий
  void emitCategoriesState() async {
    emit(CategoriesLoadingState());
    List<ProductCategory> categories = await getCategories();
    List<HomeBanner> banners = await getBanners();
    emit(CategoriesLoadedState(categories, banners));
  }

  ///Получение баннеров
  Future<List<HomeBanner>> getBanners() async {
    List<HomeBanner> banners = await catalogRepository.fetchButters();
    return banners;
  }
  ///Получение категорий
  Future<List<ProductCategory>> getCategories() async {
    List<ProductCategory> categories;

    bool exists = await hiveService.isExists(boxName: categoriesBox);
    if (exists) {
      var fromApi;
      var temp;
      var fromHive;

      var connectResult = await (connectivity.checkConnectivity());
      if (connectResult == ConnectivityResult.mobile ||
          connectResult == ConnectivityResult.wifi) {
        fromApi = await catalogRepository.fetchCatalog();
        fromHive = await hiveService.getBoxes(categoriesBox);
        temp = fromHive.cast<ProductCategory>();
        if (listEquals(fromApi, temp) != true) {
          await hiveService.addBoxes(fromApi, categoriesBox);
        }
      }

      print("Getting data from Hive");

      fromHive = await hiveService.getBoxes(categoriesBox);
      categories = fromHive.cast<ProductCategory>();
      // emit(CategoriesLoadedState(list));
    } else {
      print("Getting data from Api");
      categories = await catalogRepository.fetchCatalog();
      await hiveService.addBoxes(categories, categoriesBox);
      // print(categories[0]);
      // var list = categories.cast<ProductCategory>();
      // emit(CategoriesLoadedState(list));
    }
    return categories;
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
            emitCategoriesState();
          }
        });
  }
  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}