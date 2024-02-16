import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Liked Recipes",
        style: TextStyle(fontSize: 25),
      )),
      body: Center(
          child: Text(
        "No Fevorite Recipe Added!!!",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
