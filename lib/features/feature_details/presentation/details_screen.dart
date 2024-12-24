import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/theme/app_pallete.dart';
import 'package:products_application/features/feature_details/presentation/widgets/custom_bottom_bar_with_button.dart';

// DetailsScreen is a StatelessWidget that displays detailed information
// about a specific product. This screen is passed a 'product' object
// that contains all the information needed to populate the UI.
class DetailsScreen extends StatelessWidget {
  // 'product' is passed to the screen as a required parameter
  final Product product;
  // Constructor to initialize 'product' when the DetailsScreen is created
  const DetailsScreen({
    super.key, // The super.key allows passing a key to the parent widget
    required this.product, // The product is required and used to populate the screen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      bottomNavigationBar: CustomBottomBarWithButton(),
      appBar: AppBar(
        backgroundColor: AppPallete.whiteColor,
        leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: AppPallete.accentColor, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  color: AppPallete.whiteColor,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                  )),
            )),
      ),
      body: Column(
        children: [
          Image.network(
            product.thumbnail,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  product.description,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(product.price.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
