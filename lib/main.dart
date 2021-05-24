import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zoolife_2/logic/cubits/categories_cubit/categories_cubit.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/repositories/catalog_repository.dart';
import 'package:zoolife_2/screens/basket_page.dart';
import 'package:zoolife_2/screens/catalog_page.dart';
import 'package:zoolife_2/screens/home_page.dart';
import 'package:zoolife_2/screens/login_email_page.dart';
import 'package:zoolife_2/screens/login_phone_page.dart';
import 'package:zoolife_2/screens/profile_page.dart';
import 'package:zoolife_2/screens/search_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/splash_page.dart';
import 'screens/subcategories_page.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductCategoryAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(create: (_) =>
              InternetCubit(connectivity: Connectivity())),

          BlocProvider<CategoriesCubit>(create: (context) =>
              CategoriesCubit(catalogRepository: CatalogRepository(),
                connectivity: Connectivity())),
        ],
        child: MaterialApp(
          // theme: ThemeData(
          //   primaryColor: theme.primaryColor,
          // ),
          home: SplashPage(),
          routes: {
            '/home' : (context) => HomePage(),
            '/catalog' : (context) => CatalogPage(),
            '/catalog/subCatalog' : (context) => SubcategoriesPage(),
            '/basket' : (context) => BasketPage(),
            '/profile' : (context) => ProfilePage(),
            '/search' : (context) => SearchPage(),
            '/profile/login' : (context) => LoginPage(),
            '/profile/login/mail' : (context) => LoginEmailPage(),
          },
        )
    );
  }
}


