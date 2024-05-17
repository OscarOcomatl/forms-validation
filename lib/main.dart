import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';
                            
                            // Anteriormente era MyApp
void main() => runApp(const AppState()); // En este punto el AppState es el que debe estar en lo mas alto de la app
                                        // y el AppState ya tiene como child a MyApp

class AppState extends StatelessWidget {
  const AppState({super.key});

  // La intencion de hacerlo de esta forma es tener el AppState en nivel mas alto de la app
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => AuthService())
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
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login'   : ( _ ) => const LoginScreen(),
        'home'    : ( _ ) => const HomeScreen(),
        'product' : ( _ ) => const ProductScreen(),
        'register': ( _ ) => const RegisterScreen(),
        'checking': ( _ ) => const CheckAuthScreen() 
      },
      // En cualquier lado de la aplicacion, usando los metodos del NotificationsService
      // se tiene accesso al scaffold
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          centerTitle: true
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        )
      ),
    );
  }
}