import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
            "Mare page"
        ),
      ),
    );
  }
}

