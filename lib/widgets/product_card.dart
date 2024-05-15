import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {
  
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top:30, bottom: 50),
        width: double.infinity,
        height: 400,
        // color: Colors.red,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),

            _ProductDetails(product.name,product.id!),

            Positioned(
              top:0,
              right: 0,
              child: _PriceTag( product.price )
            ),

            // Se muestra de forma condicional, si el valor de available es false, se muestra el widget
            if(!product.available)
              Positioned(
                top:0,
                left: 0,
                child: _NotAvailable(
                  isAvailable: product.available
                )
              )


          ],
        ),
      ),
    );
  }


  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    required this.isAvailable,
  });

  final bool isAvailable;

  Widget productAvailable() {
    return isAvailable ? const Text('Disponible',style: TextStyle(color: Colors.white, fontSize: 20),) : const Text('No disponible',style: TextStyle(color: Colors.white, fontSize: 20),);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))

      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible',style: TextStyle(color: Colors.white, fontSize: 20),)
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag(this.price);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration:  const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 20))
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  // const _ProductDetails({
  //   super.key,
  // });

  final String productName;
  final String productId;

  const _ProductDetails(this.productName,this.productId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        // color: Colors.indigo,
        decoration: _buildBoxDecoration(),
        child: Column(
        //MainAxisAlignment --> vertical
        //CrossAxisAlignment --> horizontal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(productName, 
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
          ),
          Text(
            productId, 
            style: const TextStyle(
              fontSize: 15, color: Colors.white
            ),
          ),
        ],
      ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {
  // const _BackgroundImage({
  //   super.key,
  // });

  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect( // Permite ponerle border radious a la imagen
      borderRadius: BorderRadius.circular(25),
      child: SizedBox( // Era un Container, verificar que no de problemas por el uso de SizedBox en vez de container
        width: double.infinity,
        height: 400,
        child: url == null
            ? const Image(
                image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

    Widget getImage(String? picture){
  
  if(picture == null)
    return Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
  if(picture.startsWith('http')){
      FadeInImage(
        image: NetworkImage(url!),
        placeholder: const AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(picture),
      fit: BoxFit.cover
    );
  }
}