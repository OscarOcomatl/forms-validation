import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos App'),
      ),
      body: ListView.builder( //El LVB va a crear los widgets cuando esten cerca de entrar a la pantalla y no los va a mantener todos activos
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => const ProductCard()
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: (){}
      ),
    );
  }
}