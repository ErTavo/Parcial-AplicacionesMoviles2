import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/services/products_service.dart';
import 'package:productos/widgest/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if( productService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder:  (BuildContext context, int index ) => GestureDetector(
          onTap: (){
            productService.selectedProduct = productService.products[index].copyWith();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
              product: productService.products[index],
          ),
          ) 
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_shopping_cart_rounded),
            onPressed: (){
              productService.selectedProduct = new Product(
                available: false, 
                name: '', 
                picture: '', 
                price: 0);
              Navigator.pushNamed(context, 'product');
            }));
  }
   
}