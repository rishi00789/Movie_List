import 'package:flutter/material.dart';
import 'package:flutter_movie_app/pages/auth.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie List',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xff489FB5),
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.robotoMonoTextTheme()),
        home: auth());
  }
}
