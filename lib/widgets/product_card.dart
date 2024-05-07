import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
          children: [
            _BackgroundImage()
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

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
        fit: BoxFit.cover
      ),
    );
  }
}