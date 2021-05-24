import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoolife_2/constants.dart';
import 'package:zoolife_2/logic/cubits/categories_cubit/categories_cubit.dart';
import 'package:zoolife_2/logic/cubits/categories_cubit/categories_state.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/logic/cubits/search_text_field/search_text_cubit.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/widgets/catalog_Item.dart';
import 'package:zoolife_2/widgets/nointernet_widget.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';

import '../theme.dart';
import 'search_page.dart';

class CatalogPage extends StatelessWidget {
  static const route = '/catalog';
  // final WillPopCallback _onWillPop;
  late bool fromHomePage;

  CatalogPage([fromHome]) {
    this.fromHomePage = fromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<InternetCubit, InternetState>(
        buildWhen: (previousState, internetState) => previousState != internetState,
        builder: (context, internetState) {
          return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              leadingWidth: 100,
              centerTitle: true,
              backgroundColor: theme.primaryColorDark,
              // title: Text(catalog, style: TextStyle(
              //   fontSize: 16, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor
              // ),),
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
                                                                                            //Кнопка поиска
              bottom: internetState is InternetConnected ? PreferredSize(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 0, bottom: 5, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(catalog, style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor
                          ),),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                primary: theme.buttonColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (context) => SearchTextCubit(),
                                    child: SearchPage(),)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.search_rounded, color: theme.disabledColor,),
                                SizedBox(width: 10,),
                                Text(search, style: TextStyle(
                                    color: theme.disabledColor,
                                    fontFamily: familyFont),)
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  preferredSize: Size.fromHeight(80))
              : null,
            ),
            body: CatalogBody(),
            // body: internetState is InternetConnected ? CatalogBody() : NoInternetWidget(),
            bottomNavigationBar: TabSelector(currentIndex: 1,),
          );
        }
    );
  }
}

class CatalogBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, categState) {
          if (categState is CategoriesLoadedState) {
            final categories = categState.categories;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final ProductCategory category = categories[index];
                    // print((category as ProductCategory).image);
                    return CatalogItem(
                      img: category.image,
                      title: category.title,
                      subCategory: category.subCategory,
                    );
                  }),
            );
          }
          else
            return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
