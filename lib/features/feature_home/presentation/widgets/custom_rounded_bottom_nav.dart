import 'package:flutter/material.dart';
import 'package:products_application/core/theme/app_pallete.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndexValue;

  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndexValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppPallete.accentColor,
          currentIndex: currentIndexValue,
          onTap: onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: items,
        ),
      ),
    );
  }
}
