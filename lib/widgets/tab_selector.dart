import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';


class TabSelector extends StatefulWidget {

  // final ValueChanged<int> onSelectTab;
  final int currentIndex;

  TabSelector({
    Key? key,
    required this.currentIndex,
    // required this.onSelectTab,
  }) : super(key: key);

  @override
  _TabSelectorState createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.accentColor,
      unselectedItemColor: theme.disabledColor,
      backgroundColor: theme.primaryColorDark,
      currentIndex: widget.currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Stroke 1.svg',
              color: widget.currentIndex == 0 ? theme.accentColor : theme.disabledColor,),
              label: 'Главная'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Vector.svg',
            color: widget.currentIndex == 1 ? theme.accentColor : theme.disabledColor,),
            label: 'Каталог'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Vector (1).svg',
            color: widget.currentIndex == 2 ? theme.accentColor : theme.disabledColor,),
            label: 'Корзина'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Vector (2).svg',
            color: widget.currentIndex == 3 ? theme.accentColor : theme.disabledColor,),
            label: 'Профиль'),
      ],
      onTap:
          (index) {
        if (index == widget.currentIndex) return;

        if (index == 0) Navigator.of(context).pushNamedAndRemoveUntil(
            '/home', (Route route) => false);

        if (index == 1) Navigator.of(context).pushNamed('/catalog');

        if (index == 2) Navigator.of(context).pushNamed('/basket');

        if (index == 3) Navigator.of(context).pushNamed('/profile');
      }
    );
  }
}