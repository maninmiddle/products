import 'package:flutter/material.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/theme/app_pallete.dart';

class CustomCartCard extends StatefulWidget {
  final Product product;
  final void Function() onRemoveProductFromCart;

  const CustomCartCard(
      {super.key,
      required this.product,
      required this.onRemoveProductFromCart});

  @override
  _CustomCartCardState createState() => _CustomCartCardState();
}

class _CustomCartCardState extends State<CustomCartCard> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        widget.onRemoveProductFromCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            widget.product.thumbnail,
            width: 120,
            height: 120,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  widget.product.title,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(widget.product.price.toString()),
            ],
          ),
          Row(
            children: [
              MaterialButton(
                minWidth: 20,
                onPressed: _decrement,
                color: AppPallete.accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textColor: AppPallete.whiteColor,
                child: Icon(
                  Icons.remove,
                  size: 15,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                _quantity.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                minWidth: 20,
                onPressed: _increment,
                color: AppPallete.accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textColor: AppPallete.whiteColor,
                child: Icon(
                  Icons.add,
                  size: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
