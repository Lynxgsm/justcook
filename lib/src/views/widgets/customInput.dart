import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: 'Cherchez une recette ou tapez simplement un ingrédient',
            hintStyle: TextStyle(fontSize: 14, fontFamily: 'Avenir Heavy'),
            prefixIcon: Icon(Icons.search),
            focusColor: Colors.green,
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40)))),
      ),
    );
  }
}
