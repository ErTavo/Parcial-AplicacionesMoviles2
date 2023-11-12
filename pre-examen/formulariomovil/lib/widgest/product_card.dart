import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';

class ProductCard extends StatelessWidget{
  final Product product;
  const ProductCard({
    Key? key,
    required this.product
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding
    (padding: EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      margin:  EdgeInsets.only(top: 20, bottom: 50),
      width:  double.infinity,
      height: 400,
      decoration: _cardBorders(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _BackgroundImages(product.picture),
          _ProductDetails(
            title: product.name,
            subTitle: product.id!
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _PriceTag(product.price)),
          if(!product.available)
            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable())

        ],
      ),

      ),
    );
  }
  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow:[ 
      BoxShadow(
      color: Colors.black12,
      offset:  Offset(0,7),
      blurRadius: 10
    )
    ]
  );

}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag(this.price);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: TextStyle(color: Colors.white, fontSize: 20))
      ),
    ),
    width: 100,
    height: 70,
    alignment:  Alignment.center,
    decoration:  BoxDecoration(
      color: Colors.indigo,
      borderRadius:  BorderRadius.only(topRight: Radius.circular(25), bottomLeft:  Radius.circular(25))
    ),
    );
  }

}

class _ProductDetails extends StatelessWidget {

  final String title;
  final String subTitle;
  const _ProductDetails({
    required this.title,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration : _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style:  TextStyle(fontSize: 15, color:Colors.white),
            )
          ],
        ),
      )
    );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color : Colors.indigo,
    borderRadius : BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25) )
  );
}

class _BackgroundImages  extends StatelessWidget{
  final String? url;
  const _BackgroundImages(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null ? Image(
          image: AssetImage('assets/no-image.png'),
          fit:  BoxFit.cover) : FadeInImage(placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(url!),
          fit: BoxFit.cover,)
      ),
    );
  }

}

class _NotAvailable extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          ),
       ),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius:  BorderRadius.only(topLeft:  Radius.circular(25), bottomRight: Radius.circular(25))
      ),
    );
  }

}