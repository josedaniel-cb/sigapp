import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'app/app.dart';
import 'blocs/bloc_delegate.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'browser/browser_controller.dart';
import 'pages/login_page.dart';

void main() {
  // BlocSupervisor.delegate = SigappBlocDelegate();
  Bloc.observer = SigappBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Siga App',
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], //2. registered route observer
      theme: ThemeData(
        primarySwatch: App.blueColor,
        fontFamily: 'ProductSans',
      ),
      home: BlocProvider(
        create: (context) {
          LoginBloc loginBloc = LoginBloc();
          App.browserController = BrowserController(loginBloc);
          return loginBloc;
        },
        child: LoginPage(),
      ),
    );
    // return BotToastInit(
    //   child: MaterialApp(
    //     navigatorObservers: [BotToastNavigatorObserver()],
    //     title: 'The Siga App',
    //     theme: ThemeData(
    //       primarySwatch: App.blueColor,
    //       fontFamily: 'ProductSans',
    //     ),
    //     home: BlocProvider(
    //       create: (context) {
    //         LoginBloc loginBloc = LoginBloc();
    //         App.browserController = BrowserController(loginBloc);
    //         return loginBloc;
    //       },
    //       child: LoginPage(),
    //     ),
    //   ),
    // );
  }
}
