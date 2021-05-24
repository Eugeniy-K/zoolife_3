import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zoolife_2/repositories/catalog_repository.dart';
import 'package:zoolife_2/screens/home_page.dart';

import '../constants.dart';
import '../theme.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Container(
        alignment: Alignment.center,
        // color: theme.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleApp,
              style: TextStyle(
                fontSize: 35,
                color: theme.accentColor,
                fontFamily: familyFont,
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // CatalogRepository catalogRepository = CatalogRepository();
    // catalogRepository.fetchButters();

    Timer(Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomePage(),),
        ),
    );
  }
}


