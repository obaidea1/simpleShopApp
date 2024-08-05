import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/home_screen.dart';
import 'package:shoping/modules/login/login.dart';
import 'package:shoping/modules/onBoard/on_board.dart';
import 'package:shoping/shared/blok_observer.dart';
import 'package:shoping/shared/component/constant.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/network/local/cash_helper.dart';
import 'package:shoping/shared/network/remote/dio_helper.dart';
import 'package:shoping/shared/style/theme.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CashHelper.init();

  bool? onBoard = CashHelper.getData(key: 'onBoard');
  bool? login = CashHelper.getData(key: 'login');
  late Widget screen;

  if (login == true && onBoard == true) {
    screen = const HomeLayoutScreen();
    token = CashHelper.getData(key: 'token');
  } else if (onBoard == true) {
    screen = const LoginScreen();
  } else {
    screen = const OnBoard();
  }
  runApp(MyApp(
    screen: screen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  const MyApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        home: screen,
      ),
    );
  }
}
