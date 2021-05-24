import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoolife_2/constants.dart';
import 'package:zoolife_2/logic/cubits/internet/internet_cubit.dart';
import 'package:zoolife_2/logic/cubits/login/login_cubit.dart';
import 'package:zoolife_2/logic/cubits/login/phone_number_cubit.dart';
import 'package:zoolife_2/widgets/nointernet_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../theme.dart';
import 'package:formz/formz.dart';
import 'package:extended_masked_text/extended_masked_text.dart';


class LoginEmailPage extends StatelessWidget {
  @override                                                                           //Проверка интернета
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
        buildWhen: (previousState, internetState) => previousState != internetState,
        builder: (context, internetState) {
          if (internetState is InternetConnected)
            return LoginBody();
          else return Scaffold(
            backgroundColor: theme.primaryColor,
              body: NoInternetWidget());
        });
  }
}

class LoginBody extends StatelessWidget {
  final String _url = 'https://zigzagudachi.com/company/policy/';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BlocProvider(
        create: (_) => LoginCubit(),
        child: Scaffold(
          backgroundColor: theme.primaryColor,
          body: Padding(
            padding: EdgeInsets.only(
              left: 15, right: 15, top: 30
            ),
                                                                                          ///Снэк бар если не удалось войти
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.indigo,
                          content: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Container(
                                  width: 80, height: 60,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.warning_amber_outlined,
                                    size: 60, color: theme.disabledColor,
                                  )),
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text('Неверный логин или пароль',
                                        style: TextStyle(
                                            fontFamily: familyFont, fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(height: 10,),
                                    Expanded(child: Text('Пожалуйста, проверьте корректность')),
                                    Expanded(child: Text('введённых данных и повторите попытку')),
                                  ],
                                ),
                              )
                            ] ,
                          )),
                    );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () { Navigator.of(context).pop(); },
                    icon: Icon(Icons.close),),),
                  Text('Войдите по почте', style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Электронная почта', style: TextStyle(
                    fontSize: 13, color: theme.disabledColor,
                    ),
                  ),
                  SizedBox(height: 5,),
                  InputEmailWidget(),                                                  ///поле email
                  SizedBox(height: 8,),
                  Text('Пароль', style: TextStyle(
                    fontSize: 13, color: theme.disabledColor,
                    ),
                  ),
                  SizedBox(height: 5,),
                  InputPasswordWidget(),                                              ///поле пароль
                  SizedBox(height: 12,),
                  ButtonWidget(),                                                     ///кнопка войти
                  SizedBox(height: 6,),
                  Text('Нажимая на кнопку, я соглашаюсь с условиями', style: TextStyle(
                    fontSize: 13, color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                  SizedBox(height: 5,),
                  InkWell(
                    child: Text('Правила пользования торговой площадкой', style: TextStyle(
                      fontSize: 13,
                      color: theme.scaffoldBackgroundColor, decoration: TextDecoration.underline
                    ),),
                    onTap: () async {
                      if (await canLaunch(_url))
                        await launch(_url);
                      else throw 'Could not launch $_url';
                    },),
                                                                                            ///строка или
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        width: 40,
                        margin: const EdgeInsets.only(right: 20.0),
                        child: Divider(
                          color: theme.scaffoldBackgroundColor,
                          height: 50,
                          )),
                      Text("или", style: TextStyle(
                          color: theme.disabledColor, fontSize: 13),),
                      new Container(
                        width: 40,
                        margin: const EdgeInsets.only(left: 20.0,),
                        child: Divider(
                          color: theme.scaffoldBackgroundColor,
                          height: 50,
                          )),
                    ],
                  ),
                  ButtonEnterMail(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///Поле ввода пароля
class InputPasswordWidget extends StatefulWidget {
  @override
  _InputPasswordWidgetState createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          height: 38,
          child: TextField(
            obscureText: _visibility,
            keyboardType: TextInputType.visiblePassword,
            key: const Key('loginPage_emailInput_textField'),
            style: TextStyle(color: theme.scaffoldBackgroundColor),
            onChanged: (value) =>
                context.read<LoginCubit>().passwordChanged(value),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15, top: 10),
              isCollapsed: true,
              suffixIcon:  IconButton(
                  icon: _visibility ? Icon(Icons.visibility_off_outlined, color: theme.disabledColor,)
                  : Icon(Icons.visibility_outlined, color: theme.disabledColor,),
                  onPressed: () {
                    setState(() {
                      _visibility = !_visibility;
                    });
                  }),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.disabledColor, width: 0.5)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.disabledColor,
                    width: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}

///Кнопка войти по почте
class ButtonEnterMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Войти по номеру телефона',
          style: TextStyle(color: Colors.indigoAccent),),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            primary: theme.primaryColorDark,
          ),
      ),
    );
  }
}

///Кнопка Войти
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.indigo,
                    content: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: 80, height: 60,
                          alignment: Alignment.center,
                            child: Icon(
                              Icons.warning_amber_outlined,
                              size: 60, color: theme.disabledColor,
                            )),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text('Неверный формат Email',
                                  style: TextStyle(
                                      fontFamily: familyFont, fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10,),
                              Expanded(child: Text('Пожалуйста, проверьте корректность')),
                              Expanded(child: Text('введённых данных и повторите попытку')),
                            ],
                          ),
                        )
                      ] ,
                    )),
                );
            },
            child: Text('Войти'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              primary: theme.accentColor,
            ),),
        );
      },
    );
  }
}

///Поле с адресом
class InputEmailWidget extends StatelessWidget {
  InputEmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          height: 38,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            key: const Key('loginPage_emailInput_textField'),
            style: TextStyle(color: theme.scaffoldBackgroundColor),
            onChanged: (value) =>
                context.read<LoginCubit>().emailChanged(value),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15, top: 10),
              isCollapsed: true,
              suffixIcon:  Icon(Icons.email_outlined, color: theme.disabledColor,),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.disabledColor, width: 0.5)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.disabledColor,
                    width: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
