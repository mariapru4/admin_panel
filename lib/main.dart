import 'package:admin_panel/screens/admin_users_screen.dart';
import 'package:admin_panel/screens/banner_screen.dart';
import 'package:admin_panel/screens/category_screen.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/login_screen.dart';
import 'package:admin_panel/screens/notification_screen.dart';
import 'package:admin_panel/screens/orders_screen.dart';
import 'package:admin_panel/screens/settings_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCPPsoNf_IRKPlqUljAoSAh__yirj5Nn6U",
      appId: "1:215323471689:web:92805bfd3f9fbe8300b498",
      messagingSenderId: "215323471689",
      projectId: "delivery-app-79e14",
      storageBucket: "delivery-app-79e14.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dash-Board',
      theme: ThemeData(
        primaryColor: const Color(0xFF84c225),
      ),
      home: LoginScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BannerScreen.id: (context) => BannerScreen(),
        OrdersScreen.id: (context) => OrdersScreen(),
        AdminUsersScreen.id: (context) => AdminUsersScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
      },
    );
  }
}
