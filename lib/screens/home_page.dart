import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoolife_2/logic/cubits/categories_cubit/categories_cubit.dart';
import 'package:zoolife_2/logic/cubits/categories_cubit/categories_state.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/logic/cubits/search_text_field/search_text_cubit.dart';
import 'package:zoolife_2/models/banner.dart';
import 'package:zoolife_2/models/product_category.dart';
import 'package:zoolife_2/screens/search_page.dart';
import 'package:zoolife_2/theme.dart';
import 'package:zoolife_2/widgets/home_catalog_item.dart';
import 'package:zoolife_2/widgets/nointernet_widget.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';
import '../constants.dart';


class HomePage extends StatelessWidget {
  static const route = '/home';
  // final ValueChanged<int> onSelectTab;
  //
  // HomePage(this.onSelectTab);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      buildWhen: (previousState, internetState) => previousState != internetState,
        builder: (context, internetState) {
          return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.primaryColorDark,
              title: Column(
                children: [
                  Text(
                    titleApp,
                    style: TextStyle(
                      fontSize: 35,
                      color: theme.accentColor,
                      fontFamily: 'ArialNova',
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(color: theme.accentColor, height: 10, width: 75,),
                      Container(color: theme.primaryColorLight, height: 10, width: 80,),
                    ],
                  ),
                ],
              ),
              bottom: internetState is InternetConnected ? PreferredSize(                             //кнопка поиска
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 0, bottom: 5, right: 10),
                  child: Container(
                    // width: MediaQuery.of(context).size.width - 20,
                    // height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        primary: theme.buttonColor
                      ),
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/search');
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
                              fontFamily: 'ArialNova'),)
                        ],
                      ),
                    ),
                  )
                ),
                preferredSize: Size.fromHeight(50))
                : null
            ),
            body: internetState is InternetConnected ? HomeBody() : NoInternetWidget(),
            bottomNavigationBar: TabSelector(currentIndex: 0,),
          );
        });
  }
}


class HomeBody extends StatelessWidget {
  Future<void> test() async { }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadedState)
          return Padding(
            padding: EdgeInsets.only(top: 15, left: 5, right: 5),
            child: RefreshIndicator(
              backgroundColor: theme.primaryColorDark,
              color: theme.scaffoldBackgroundColor,
              onRefresh: () async {
                context.read<CategoriesCubit>().emitCategoriesState();
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  MyCarouselSlider(bannersList: state.banners,),
                  SizedBox(height: 10,),
                  CategoriesList(state.categories),
                ],
              ),
            ),
          );
        else return Center(child: CircularProgressIndicator());
      },

    );
  }
}

class CategoriesList extends StatelessWidget {
  final List<ProductCategory> categories;

  CategoriesList(this.categories);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final ProductCategory category = categories[index];
          return HomeCatalogItem(
              img: category.image,
              title: category.title,
              subCategory: category.subCategory);
        }
      ),
    );
  }


}

///Карусель баннеров
class MyCarouselSlider extends StatefulWidget {

  final List<HomeBanner> bannersList;
  const MyCarouselSlider({required this.bannersList});

  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  int _current = 0;
  double _widthIndicator = 8;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
            items: widget.bannersList.map((e) {
              return Builder(
                  builder: (BuildContext context) {
                    return Banners(e.imageUrl);
                  });
            }).toList(),
            options: CarouselOptions(
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              autoPlayInterval: Duration(seconds: 3),
              height: 100,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  _widthIndicator = 8.0;

                });
              }
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.bannersList.map((url) {
            int index = widget.bannersList.indexOf(url);
            return Stack(
              children: [
                Container(
                width: _current == index
                  ? 18.0
                  : 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromRGBO(0, 0, 0, 0.4)
                ),
              ),
                Container(
                  width: _current == index
                      ? _widthIndicator
                      : 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ]
    );
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {setState(() {
      _widthIndicator += 0.6;
      if (_widthIndicator >= 20.0)
        _widthIndicator = 8.0;
      // print(_widthIndicator.toString());
    });});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

///Баннер
class Banners extends StatelessWidget {
  final String imgUrl;

  Banners(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/catalog'),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height*0.30,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: CachedNetworkImage(imageUrl: imgUrl)),
      ),
    );
  }


}

