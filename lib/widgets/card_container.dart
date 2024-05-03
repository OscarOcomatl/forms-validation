import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({ super.key, required this.child});

  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        // height: 300, 
        // color: Colors.red
        padding: const EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow( // Para crearle una sombra al contenedor
        color: Colors.black12,
        blurRadius: 15,
        offset: Offset(0, 5) // aqui los valores son x, y
      )
    ] 
  );
}