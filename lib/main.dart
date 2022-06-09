import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/layout/home_layout.dart';
import 'package:udemy_course/modules/counter/counter_screen.dart';
import 'package:udemy_course/modules/messenger/messenger_screen.dart';
import 'package:udemy_course/modules/users/users_screen.dart';
import 'package:udemy_course/shared/bloc_observer.dart';

import 'modules/bmi/bmi_screen.dart';
import 'modules/login/login_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
