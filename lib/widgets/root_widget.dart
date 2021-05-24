// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:zoolife_2/models/tab_item.dart';
// import 'package:zoolife_2/screens/basket_page.dart';
// import 'package:zoolife_2/screens/catalog_page.dart';
// import 'package:zoolife_2/screens/home_page.dart';
// import 'package:zoolife_2/screens/profile_page.dart';
// import 'package:zoolife_2/widgets/tab_selector.dart';
//
// import '../bottom_navigation_bar_root_item.dart';
// import '../theme.dart';
//
//
// ///Виджет для отображения содержимого вкладок
// class RootWidget extends StatefulWidget {
//   @override
//   RootWidgetState createState() => RootWidgetState();
// }
//
// class RootWidgetState extends State<RootWidget> {
//
//   static int currentTab = 0;
//   List<int> stackTabs = [0];
//
//   // list tabs here
//   late final List<TabItem> tabs = [
//     TabItem(
//       tabName: "Главная",
//       icon: Icons.home_outlined,
//       page: HomePage(_selectTab),
//     ),
//     TabItem(
//       tabName: "Каталог",
//       icon: Icons.search_rounded,
//       page: CatalogPage(_onWillPop),
//     ),
//     TabItem(
//       tabName: "Корзина",
//       icon: Icons.shopping_bag_outlined,
//       page: BasketPage(),
//     ),
//     TabItem(
//       tabName: "Профиль",
//       icon: Icons.account_circle_outlined,
//       page: ProfilePage(),
//     ),
//   ];
//
//   RootWidgetState() {
//     // indexing is necessary for proper funcationality
//     // of determining which tab is active
//     tabs.asMap().forEach((index, details) {
//       details.setIndex(index);
//     });
//   }
//
//   Future<bool> _onWillPop() async {
//     final isFirstRouteInCurrentTab =
//     !await tabs[stackTabs.last].key.currentState!.maybePop();
//     if (isFirstRouteInCurrentTab) {
//       // if not on the 'main' tab
//       if (stackTabs.length != 1) {
//         // select previous tab
//         stackTabs.removeLast();
//         _selectTab(stackTabs.last);
//         // back button handled by app
//         return false;
//       }
//     }
//     // let system handle back button if we're on the first route
//     return isFirstRouteInCurrentTab;
//   }
//
//   // sets current tab index
//   // and update state
//   void _selectTab(int index) {
//     if (index == currentTab) {
//       // pop to first route
//       // if the user taps on the active tab
//       tabs[index].key.currentState?.popUntil((route) => route.isFirst);
//     } else {
//       if (stackTabs.last != index)
//         stackTabs.add(index);
//       // update the state
//       // in order to repaint
//       setState(() {
//         currentTab = index;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // WillPopScope handle android back btn
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       // onWillPop: () async {
//       //   final isFirstRouteInCurrentTab =
//       //   !await tabs[stackTabs.last].key.currentState!.maybePop();
//       //   if (isFirstRouteInCurrentTab) {
//       //     // if not on the 'main' tab
//       //     if (stackTabs.length != 1) {
//       //       // select 'main' tab
//       //       stackTabs.removeLast();
//       //       _selectTab(stackTabs.last);
//       //       // back button handled by app
//       //       return false;
//       //     }
//       //   }
//       //   // let system handle back button if we're on the first route
//       //   return isFirstRouteInCurrentTab;
//       // },
//       // this is the base scaffold
//       // don't put appbar in here otherwise you might end up
//       // with multiple appbars on one screen
//       // eventually breaking the app
//       child: Scaffold(
//         // indexed stack shows only one child
//         body: IndexedStack(
//           index: currentTab,
//           children: tabs.map((e) => e.page).toList(),
//         ),
//         // Bottom navigation
//         bottomNavigationBar: TabSelector(
//           onSelectTab: _selectTab,
//           tabs: tabs,
//         ),
//       ),
//     );
//   }
// }
