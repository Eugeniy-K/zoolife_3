import 'package:flutter/material.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';

import '../constants.dart';
import '../theme.dart';

class ProfilePage extends StatelessWidget {
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        backgroundColor: theme.primaryColorDark,
                                                                                    //кнопка назад
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
        bottom: PreferredSize(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15, bottom: 15),
              child: Text(profile, style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor
              ),),
            ),
            preferredSize: Size.fromHeight(50)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            Text('Войдите или зарегистрируйтесь', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor,
              ),
            ),
            SizedBox(height: 20,),
            Text('Чтобы делать покупки и отслеживать заказы', style: TextStyle(
              fontSize: 14, color: theme.scaffoldBackgroundColor,
              ),
            ),
            SizedBox(height: 15,),                                                        //Кнопка войти
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/profile/login');
              },
              child: Text('Войти или зарегистрироваться'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onSurface: theme.accentColor,
                primary: theme.accentColor,
              ),),
            SizedBox(height: 20,),
            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(border: Border(
                    top: BorderSide(
                        width: 0.5, color: theme.disabledColor),)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Доставка', style: TextStyle(
                      color: theme.scaffoldBackgroundColor, fontSize: 16
                    ),),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15,
                      color: theme.disabledColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(border: Border(
                  top: BorderSide(
                      width: 0.5, color: theme.disabledColor),)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Оплата', style: TextStyle(
                        color: theme.scaffoldBackgroundColor, fontSize: 16
                    ),),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15,
                      color: theme.disabledColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(border: Border(
                  top: BorderSide(
                      width: 0.5, color: theme.disabledColor),
                  )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Пункты выдачи', style: TextStyle(
                        color: theme.scaffoldBackgroundColor, fontSize: 16
                    ),),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15,
                      color: theme.disabledColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(border: Border(
                  top: BorderSide(
                      width: 0.5, color: theme.disabledColor),)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('О компании', style: TextStyle(
                        color: theme.scaffoldBackgroundColor, fontSize: 16
                    ),),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15,
                      color: theme.disabledColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(border: Border(
                  top: BorderSide(
                    width: 0.5, color: theme.disabledColor),
                  bottom: BorderSide(
                      width: 0.5, color: theme.disabledColor),)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('О приложении', style: TextStyle(
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
      bottomNavigationBar: TabSelector(currentIndex: 3,),
    );
  }
}
