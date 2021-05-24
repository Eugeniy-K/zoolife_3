import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/screens/subcategories_page.dart';

class HomeCatalogItem extends StatelessWidget {

  final String img;
  final String title;
  final List<ProductCategory> subCategory;

  const HomeCatalogItem({
    required this.img, required this.title, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            '/catalog/subCatalog',
            arguments: ScreenArgumentsSubCategories(title, subCategory));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // child: Image.network(img, height: 60, width: 60,),
              child: CachedNetworkImage(imageUrl: img, height: 60, width: 60,),
            ),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
