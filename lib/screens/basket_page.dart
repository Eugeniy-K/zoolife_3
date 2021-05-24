
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoolife_2/constants.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/logic/cubits/search_text_field/search_text_cubit.dart';
import 'package:zoolife_2/widgets/nointernet_widget.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';

import '../theme.dart';
import 'search_page.dart';

class BasketPage extends StatelessWidget {
  static const route = '/basket';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      buildWhen: (previousState, internetState) => previousState != internetState,
      builder: (context, internetState) {
        return Scaffold(
          backgroundColor: theme.primaryColor,
          appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15, bottom: 15),
                  child: Text(basket,
                    style: TextStyle(
                        fontSize: 22, fontFamily: 'ArialNova',
                        color: theme.scaffoldBackgroundColor, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(50)),
            // title: Text(basket, style: TextStyle(
            //     fontSize: 20, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor
            // ),),
            leadingWidth: 100,
            centerTitle: true,
            backgroundColor: theme.primaryColorDark,
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: internetState is InternetConnected ? BasketEmpty()
                : NoInternetWidget(),),
                                                                                  //Панель Оформить заказ
                Container(
                  color: theme.primaryColorDark,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('0 руб.',
                              style: TextStyle(
                                  fontFamily: familyFont,
                                  color: theme.scaffoldBackgroundColor,
                                  fontSize: 16),),
                            Text('0 товаров',
                              style: TextStyle(
                                  fontFamily: familyFont,
                                  color: theme.disabledColor,
                                  fontSize: 13),)
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: Text('Оформить заказ'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                            ),
                            onSurface: theme.accentColor,
                            primary: theme.accentColor,
                        ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: TabSelector(currentIndex: 2,),
        );
      },
    );
  }
}

class BasketEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Корзина пуста', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor,
          ),),
          SizedBox(height: 20,),
          Text('Воспользуйтесь каталогом, чтобы', style: TextStyle(
              fontSize: 15,  color: theme.disabledColor,
          ),),
          Text('выбрать всё, что нужно', style: TextStyle(
            fontSize: 15,  color: theme.disabledColor,
          ),),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => SearchTextCubit(),
                    child: SearchPage(),)));
            },
            child: Text('Начать покупки'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onSurface: theme.accentColor,
              primary: theme.accentColor,
            ),)
        ],
      ),);
  }
}
