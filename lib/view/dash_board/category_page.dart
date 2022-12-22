import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
            "Category page"
        ),
      ),
    );
  }
}

