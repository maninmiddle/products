import 'package:flutter/material.dart';
import 'package:products_application/core/model/product.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  final void Function() onTapListener;
  final void Function() onPressedButton;
  final void Function() onRemoveProductFromCart;

  const CustomProductCard(
      {super.key,
      required this.product,
      required this.onTapListener,
      required this.onPressedButton,
      required this.onRemoveProductFromCart});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapListener,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.network(
              product.thumbnail,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              product.price.toString(),
            ),
            ElevatedButton(
              onPressed: onPressedButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: Text("Add to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
