import 'package:flutter/material.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/widgets/catalog_Item.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';

import '../theme.dart';

class SubcategoriesPage extends StatelessWidget {
  // final String title;
  // final List<ProductCategory> subCategory;
  //
  // SubcategoriesPage(this.title, this.subCategory);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsSubCategories;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        backgroundColor: theme.primaryColorDark,
        title: Text(args.title, style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor
        ),),
        //Кнопка назад
        leading: TextButton(
          onPressed: (){ Navigator.of(context).pop(); },
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(0),
                  child: Icon(Icons.arrow_back_ios,
                    color: theme.disabledColor,)),
              Text('Назад',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'ArialNova',
                    color: theme.disabledColor
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
            itemCount: args.subCategory.length,
            itemBuilder: (context, index) {
              final category = args.subCategory[index];
              return CatalogItem(
                  img: category.image,
                  title: category.title,
                  subCategory: category.subCategory,
              );
            }),
      ),
      bottomNavigationBar: TabSelector(currentIndex: 1,),
    );
  }
}

class ScreenArgumentsSubCategories {
  final String title;
  final List<ProductCategory> subCategory;

  ScreenArgumentsSubCategories(this.title, this.subCategory);
}
