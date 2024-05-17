import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    

    if(productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined)), // Por si se quiere dejar de lado izquierdo
        actions: [ 
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white,),
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, 'login'); // Automaticamente destruye el stack de screens y regresa a la que especificamos
            },
          ),
        ]
      ),
      body: ListView.builder( //El LVB va a crear los widgets cuando esten cerca de entrar a la pantalla y no los va a mantener todos activos
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () => {
            productsService.selectedProduct = productsService.products[index].copy(), //Para romper la referencia y no modificar la lista original
            Navigator.pushNamed(context,'product'),
          },
          child: ProductCard(product: productsService.products[index]) //Se le envia el producto
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: (){
          // Hay que crear el producto porque si no, da errores
          productsService.selectedProduct = Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        }
      ),
    );
  }
}