
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseURL = 'flutter-projects-f90dd-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      //es necesario crear
      await createProduct(product);
    }else{
      //Actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseURL,'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson() ); //Put para actualizar
    final decodedData = resp.body;

    // print(decodedData);

    //TODO: Actualizar la lista de productos
    // if(product.id == products[0].id){    // Oscar
    //   products[0].name = product.name;
    // }

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

    Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseURL,'products.json');
    final resp = await http.post(url, body: product.toJson() ); //Put para actualizar
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];
    this.products.add(product);

    // print(decodedData);
    // this.products.add(product);

    return '';
  }

}