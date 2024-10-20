import 'package:examen_final/routes/app_routes.dart';
import 'package:examen_final/services/auth_service.dart';
import 'package:examen_final/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/my_theme.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) =>  ProductService())
      ],
      child: const MyApp(), 
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen final',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,  
    );
  }
}
