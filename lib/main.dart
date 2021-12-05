import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_chat/resources/firebase_store.dart';
import 'package:new_chat/screens/home_screen.dart';
import 'package:new_chat/screens/login_screen.dart';
import 'package:new_chat/screens/search_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {

    //test đăng xuất
    // _repository.signOut(); ko bỏ dồng này sẽ bị đăng xuất vĩnh viễn =))
    
    return MaterialApp(
      title: "New_Chat",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/search_screen': (context) => SearchScreen(),
      },
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: FutureBuilder(
        future: _repository.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}