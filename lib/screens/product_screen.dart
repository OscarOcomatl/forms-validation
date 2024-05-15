import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';

import 'package:productos_app/services/services.dart';

import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productService.selectedProduct), //No importa donde se creo, ahora se tiene acceso a la instancia del prductFormProvider
      child: _ProductScreenBody(productService: productService),
    );

    // return _ProductScreenBody(productService: productService);
  }

}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual , // Cuando se haga scroll se va a ocultar el teclado
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage( url: productService.selectedProduct.picture, ),
                // _backButton(context),
                Positioned(
                top: 60,
                right: 20,
                child: IconButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    // final PickedFile? pickedFile = await picker.pickImage( source: ImageSource.camera);
                    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
                    if(pickedFile == null) {
                      print('No selecciono nada');
                      return;
                    }
                    // print('Imagen: ${pickedFile.path}');
                    productService.updateSelectedProductImage(pickedFile.path);
                  },
                  icon: const Icon(Icons.camera_alt_outlined, size: 50, color: Colors.white70,)
                )
                ),
                // _cameraButton(),
                Positioned(
                top: 60,
                left: 20,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white70,)
                )
                )
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100,) //Para que el scroll pueda pasar despues del input
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving
        ? null
        : () async {
          // TODO: Guardar producto
          if( !productForm.isValidForm() ) return;

          final String? imageUrl = await productService.uploadImage();

          // print(imageUrl);

          if(imageUrl != null) productForm.product.picture = imageUrl;

          await productService.saveOrCreateProduct(productForm.product);
        },
        child: productService.isSaving 
        ? const CircularProgressIndicator(color: Colors.white,)
        : const Icon(Icons.save_outlined, color: Colors.white,),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
  final productForm = Provider.of<ProductFormProvider>(context);
  final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        // height: 200,
        decoration: _buildBoxDecoration(),
        child: Form(
          key:productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                initialValue: product.name,
                decoration: const InputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:'
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value) == null){
                    product.price = 0;
                  }else {
                    
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:'
                ),
              ),
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: product.available, 
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability,
                // onChanged: (value) => productForm.updateAvailability(value)
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
