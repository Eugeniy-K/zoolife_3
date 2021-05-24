import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:zoolife_2/constants.dart';
import 'package:zoolife_2/models/banner.dart';
import 'package:zoolife_2/models/product_category.dart';

class CatalogRepository {

  var dio = Dio();
  final String headerKey = "x-api-key";
  final String headerDevId = "X-Device-Id";

  ///Получаем каталог
  Future<List<ProductCategory>> fetchCatalog() async {
    String deviceId = await _getId();
    late Response response;
    try {
      response = await dio.get(baseUrl + 'catalog/sections',
        options: Options(
          headers: {
            "x-api-key": apiKey,
            "X-Device-Id": deviceId
          }
        ));
    }
    catch (error, trace) {
      print("Exception occured: $error stackTrace: $trace");
    }
    if (response.statusCode != 200) {
      throw Exception('Что то пошло не так');
    }
    // print(response);
    var catalogJson = jsonDecode(response.data)['data'] as List;
    ///Список всех категорий
    final List<ProductCategory> allCategories = catalogJson.map((category) =>
      ProductCategory.fromJson(category)).toList();

    ///Категории
    final List<ProductCategory> categories = allCategories.where((category) =>
      category.hasChild == true).toList();
    ///Подкатегории
    final List<ProductCategory> subCategories = allCategories.where((category) =>
    category.parentId != null).toList();
    ///Заполнение подкатегорий в категориях
    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < subCategories.length; j++) {
        if (subCategories[j].parentId == categories[i].sectionId) {
          categories[i].subCategory.add(subCategories[j]);
        }
      }
    }
    // print(subCategories.toString());
    return categories;
  }

  ///Получаем баннер
  Future<List<HomeBanner>> fetchButters() async {
    String deviceId = await _getId();
    late Response response;
    try {
      response = await dio.get(baseUrl + 'banners',
          options: Options(
              headers: {
                "x-api-key": apiKey,
                "X-Device-Id": deviceId
              }
          ));
    }
    catch (error, trace) {
      print("Exception occured: $error stackTrace: $trace");
    }
    if (response.statusCode != 200) {
      throw Exception('Что то пошло не так');
    }

    var bannerJson = jsonDecode(response.data)['data'] as List;
    final List<HomeBanner> banners = bannerJson.map((category) =>
        HomeBanner.fromJson(category)).toList();
    return banners;
  }

  ///Получаем id смартфона
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}