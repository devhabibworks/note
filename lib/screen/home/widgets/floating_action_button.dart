import 'package:flutter/material.dart';

class CustomFloating extends StatelessWidget {
  Function()? onPressed;
  CustomFloating({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      extendedPadding: const EdgeInsets.symmetric(horizontal: 28),
    );
  }
}
