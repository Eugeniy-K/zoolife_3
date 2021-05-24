import 'package:flutter/material.dart';
import 'package:zoolife_2/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/error (1) 1.svg'),
          SizedBox(height: 20,),
          Text(noInternet,
            style: TextStyle(
              color: theme.scaffoldBackgroundColor,
              fontSize: 20, fontWeight: FontWeight.bold
            ),),
          SizedBox(height: 20,),
          Text(pleaseConnect,
            style: TextStyle(
              color: theme.disabledColor
            ),),
          SizedBox(height: 15,),
          Container(
            height: 45,
            child: OutlinedButton(
              child: Text('Обновить',
                style: TextStyle(color: theme.disabledColor),),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.scaffoldBackgroundColor),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
                )
              ),
              onPressed: () {}),
          )
        ],
      ),
    );
  }
}
