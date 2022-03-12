import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider_clean_code/services/get_it.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetItService.initialize();
  runApp(const MyApp());
}
