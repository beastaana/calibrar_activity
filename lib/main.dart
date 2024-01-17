import 'package:calibrar_activity/presentation/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/navigation_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RootPage(),
      ),
    );
  }
}