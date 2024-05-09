
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseURL = 'flutter-projects-f90dd-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  late Product selectedProduct;

  //TODO: Hacer fetch de productos

  ProductsService(){
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseURL,'products.json');
    final resp = await http.get(url);
    final Map<String,dynamic> productsMap = jsonDecode(resp.body);

                      // key : {value}
    productsMap.forEach((key, value) { 
      // Convertir a lista desde un mapa
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    

    isLoading = false;
    notifyListeners();
    // print(products[0].name);
    // print(productsMap);
    return products;
  }

}