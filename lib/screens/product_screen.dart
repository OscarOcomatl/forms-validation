import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const ProductImage(),
                _backButton(context),
                _cameraButton(),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100,) //Para que el scroll pueda pasar despues del input
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // TODO: Guardar producto
        },
        child: Icon(Icons.save_outlined, color: Colors.white,),
      ),
    );
  }

  Positioned _cameraButton() {
    return Positioned(// para ubicar en cierta posicion dentro del stack
                top: 60,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    // Camara o galeria
                  },
                  icon: const Icon(Icons.camera_alt_outlined, size: 50, color: Colors.white70,)
                )
              );
  }

  Positioned _backButton(BuildContext context) {
    return Positioned(// para ubicar en cierta posicion dentro del stack
                top: 60,
                left: 20,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white70,)
                )
              );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        // height: 200,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:'
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:'
                ),
              ),
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: true, 
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) {
                  //TODO: Pendiente
                }
                ),
              const SizedBox(height: 30,)
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5
        )
      ]
    );
  }
}