import 'package:flutter/material.dart';
import 'package:pattern_setstate/pages/create_post_page.dart';
import 'package:pattern_setstate/pages/home.dart';
import 'package:pattern_setstate/pages/update_post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        Home.id: (context) => Home(),
        Create_post.id: (context) => Create_post(),
      },
    );
  }
}
