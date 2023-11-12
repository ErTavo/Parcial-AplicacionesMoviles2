import 'package:flutter/material.dart';
import 'package:productos/providers/product_form_provider.dart';
import 'package:productos/services/api_service.dart';
import 'package:productos/services/products_service.dart';
import 'package:productos/ui/input_decorations.dart';
import 'package:productos/widgets/product_image.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductFormProvider(productService.selectedProduct)),
        ChangeNotifierProvider(create: (_) => ApiService()),
      ],
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;

  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final apiService = Provider.of<ApiService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              ProductImage(url: productService.selectedProduct.picture),
              Positioned(
                top :60,
                left: 20,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(), 
                  icon: Icon(Icons.arrow_back,size: 40,color: Colors.white,))
                  ),
              Positioned(
                top: 60,
                left: 20,
                child: IconButton(
                  onPressed: () async{
                    final  picker = new ImagePicker();
                    final PickedFile? pickedFile = (await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 100)) as PickedFile?;
                    if (pickedFile == null){
                      print('No selecciono nada');
                      return;
                    }
                    productService.updateSelectedProductImage(pickedFile.path);
                  },
                  icon: Icon(Icons.camera_alt_rounded, size: 40,color: Colors.white,),
                ),
              )
              ),
              _ProductForm()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving ? CircularProgressIndicator(color: Colors.white60) : 
        Icon(Icons.save_outlined),
        onPressed: productService.isSaving ? null :
        () async {
          if(!productForm.isValidForm()) return;
          final String? imageUrl = await productService.uploadImage();
          //Validar si la imagen se subio de forma correcta
          if( imageUrl != null) productForm.product.picture = imageUrl;
          //Guardar , mendiante post al API
          await productService.saveOrCreateProduct(productForm.product);

        }),
    );
  }}

  class _ProductForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value){
                  if(value == null || value.length < 1)
                  return "EL campo nombre es obligatorio"
                
                  return null;},
                  decoration: InputDecorations.authInputDecoration(
                    hintText: "Producto", labelText: "Nombre")
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if(double.tryParse(value)== null){
                    product.price = 0;
                  }else{
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(hintText: "Q150", labelText: "Precio"),

              ),
              SizedBox(height: 30,),
              SwitchListTile.adaptive(value: product.available, 
              activeColor: Colors.indigo,
              hoverColor: Colors.blueGrey,
              title:  Text("Disponible"),
              onChanged: productForm.updateAvailability(product.available)),
              SizedBox(height: 30,)


            ],
          )),
      ),      
    );
  }
  
    BoxDecoration _buildBoxDecoration()=>  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25) ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          offset: Offset(0,5),
          blurRadius: 5
        )
      ]
    );
  }