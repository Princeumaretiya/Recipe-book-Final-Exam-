import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/database_helper.dart';
import '../model/food_recipe_model.dart';

import 'package:sqflite/sqflite.dart';

class FoodRecipeController extends GetxController {
  RxList<FoodRecipe> foodRecipes = <FoodRecipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDataFromDatabase();
  }

  getDataFromDatabase() async {
    foodRecipes.value = await DatabaseHelper.getItems();
    update();
  }

  addFav(String title, String des, String image, int id) async {
    await FirebaseFirestore.instance
        .collection('Recipes')
        .doc()
        .set({'title': title, 'des': des, 'image': image, 'id': id});
  }
}
