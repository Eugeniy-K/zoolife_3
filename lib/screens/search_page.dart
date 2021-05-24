import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/logic/cubits/search_text_field/search_text_cubit.dart';
import 'package:zoolife_2/theme.dart';
import 'package:zoolife_2/widgets/tab_selector.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textController = TextEditingController();


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
        builder: (context, internetState) {
          return BlocBuilder<SearchTextCubit, SearchTextState>(
            builder: (context, textState) {
              return Scaffold(
                backgroundColor: theme.primaryColorDark,
                appBar: AppBar(
                  backgroundColor: theme.primaryColorDark,
                  leadingWidth: 40,
                  title: Container(
                    height: 35,                                                             //Поле поиска
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: theme.scaffoldBackgroundColor),
                      controller: _textController,
                      onChanged: (value) =>
                        context.read<SearchTextCubit>().searchTextChanged(value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 8),
                        isCollapsed: true,
                        suffixIcon: (textState as SearchTextUpdated).searchText == '' ? IconButton(
                            icon: Icon(Icons.search, color: theme.disabledColor,),
                            onPressed: () {})
                          : IconButton(
                            icon: Icon(Icons.close, color: Colors.black,),                //Кнопка очистить
                            onPressed: () {
                              _textController.clear();
                              context.read<SearchTextCubit>().searchTextChanged(_textController.text);
                              }),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        hintText: 'Искать в Зоолайфе',
                        hintStyle: TextStyle(color: theme.disabledColor),
                      ),
                    ),
                  ),
                                                                                      //Кнопка назад
                  leading: TextButton(
                    onPressed: () { Navigator.of(context).pop(); },
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.all(0),
                            child: Icon(Icons.arrow_back,
                              color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: TabSelector(currentIndex: 1,),
              );
            },
            // child:
          );
        });
  }
}
