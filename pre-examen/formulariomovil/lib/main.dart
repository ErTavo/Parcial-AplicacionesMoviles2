import 'package:flutter/material.dart';
import 'package:productos/screens/screens.dart';
import 'package:provider/provider.dart';

import 'services/products_service.dart';

void main() {
  runApp(const MyApp());
}
class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ProductService() )
      ],
      child: const MyApp()
      );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',      
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'login': ( _ ) => const LoginScreen(),
        'home': ( _ ) => const HomeScreen(),
        'product': ( _ ) => const ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor:  Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ), 
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

