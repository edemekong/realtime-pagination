import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_clean_code/pages/home/home_state.dart';
import 'package:provider_clean_code/pages/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeState()),
      ],
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
