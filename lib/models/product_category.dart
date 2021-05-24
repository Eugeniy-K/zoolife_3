import 'package:hive/hive.dart';
part 'product_category.g.dart';


@HiveType(typeId: 0)
class ProductCategory {

  @HiveField(0)
  final String sectionId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final bool hasChild;
  @HiveField(4)
  final String? parentId;
  @HiveField(5)
  List<ProductCategory> subCategory = [];

  ProductCategory(
      this.sectionId, this.title, this.image, this.hasChild, this.parentId);

  static ProductCategory fromJson(dynamic json) {
    return ProductCategory(
        json['sectionId'] as String,
        json['title'] as String,
        json['image'] as String,
        json['hasChild'] as bool,
        json['parentId'] is bool ? null : json['parentId'] as String );
  }
}