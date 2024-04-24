import 'package:flutter/material.dart';

class ConstantHeight extends StatelessWidget {
  final double size;
  const ConstantHeight({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * size,
    );
  }
}
