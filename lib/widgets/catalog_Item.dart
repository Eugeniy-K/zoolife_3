import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/screens/subcategories_page.dart';

import '../theme.dart';

class CatalogItem extends StatelessWidget {
  final String img;
  final String title;
  final List<ProductCategory> subCategory;
  const CatalogItem({required this.img, required this.title, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (subCategory.isNotEmpty)
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (_) => SubcategoriesPage(title, subCategory)));
          Navigator.of(context).pushNamed(
              '/catalog/subCatalog',
              arguments: ScreenArgumentsSubCategories(title, subCategory));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            img != '' ? CachedNetworkImage(
               width: 30, height: 30, imageUrl: img,) : Container(),
            img != '' ? SizedBox(width: 10,) : Container(),
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(bottom: 10),
                height: 30,
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: theme.disabledColor),)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(title, style: TextStyle(
                        color: theme.scaffoldBackgroundColor, fontSize: 16
                    ),),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15,
                      color: theme.disabledColor,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
