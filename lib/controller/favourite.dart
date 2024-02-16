import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<String> favoritrecipe = <String>[].obs;

  void toggleFavorite(String recipe) {
    if (favoritrecipe.contains(recipe)) {
      favoritrecipe.remove(recipe);
    } else {
      favoritrecipe.add(recipe);
    }
  }

  bool isFavorite(String recipe) {
    return favoritrecipe.contains(recipe);
  }
}
