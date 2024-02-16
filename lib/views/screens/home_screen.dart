import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/database_helper.dart';
import '../../controller/favourite.dart';
import '../../controller/food_recipe_controller.dart';
import '../../model/food_recipe_model.dart';
import 'Liked_recipe_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FoodRecipeController foodRecipeController =
      Get.put(FoodRecipeController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 30, color: Colors.black),
        backgroundColor: Colors.cyan,
        title: Text(
          'Recipe Book',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  "Prince Umaretiya",
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(0.0),
                accountEmail: Text("prince2003@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    "PU",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_right_sharp,
                size: 25,
                color: Colors.black,
              ),
              title: const Text(
                'Favorite',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: foodRecipeController.foodRecipes.length,
            itemBuilder: (context, index) {
              var recipe = foodRecipeController.foodRecipes[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(recipe.imageUrl),
                ),
                title: Text(
                  recipe.name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(recipe.description),
                trailing: IconButton(
                  icon: Icon(
                    CupertinoIcons.heart,
                  ),
                  onPressed: () async {
                    await foodRecipeController.addFav(recipe.name,
                        recipe.description, recipe.imageUrl, recipe.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecipeDialog(context),
        tooltip: 'Add Recipe',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRecipeDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    // TextEditingController idController = TextEditingController();
    // favoriteController = Get.put(FavoriteController());

    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();
    IconData selectedIcon = Icons.fastfood; // Default icon

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Recipe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              DropdownButtonFormField<IconData>(
                value: selectedIcon,
                items: [
                  DropdownMenuItem(
                    value: Icons.fastfood,
                    child: Icon(Icons.fastfood),
                  ),
                  DropdownMenuItem(
                    value: Icons.local_pizza,
                    child: Icon(Icons.local_pizza),
                  ),
                  // Add more icons as needed
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedIcon = value;
                  }
                },
                decoration: InputDecoration(labelText: 'Select Icon'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper.createItem(nameController.text,
                    descriptionController.text, imageUrlController.text);
                foodRecipeController.getDataFromDatabase();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   final FoodRecipeController foodRecipeController = Get.put(FoodRecipeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Food Recipes'),
//       ),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: foodRecipeController.foodRecipes.length,
//           itemBuilder: (context, index) {
//             var recipe = foodRecipeController.foodRecipes[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(recipe.imageUrl),
//               ),
//               title: Text(recipe.name),
//               subtitle: Text(recipe.description),
//               trailing: Icon(recipe.icon),
//               onLongPress: () => _showEditRecipeDialog(context, recipe),
//             );
//           },
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddRecipeDialog(context),
//         tooltip: 'Add Recipe',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   // Function to show the Add Recipe dialog
//   void _showAddRecipeDialog(BuildContext context) {
//     // ... (unchanged)
//   }
//
//   // Function to show the Edit Recipe dialog
//   void _showEditRecipeDialog(BuildContext context, FoodRecipe recipe) {
//     TextEditingController nameController = TextEditingController(text: recipe.name);
//     TextEditingController descriptionController = TextEditingController(text: recipe.description);
//     TextEditingController imageUrlController = TextEditingController(text: recipe.imageUrl);
//     IconData selectedIcon = recipe.icon;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit Recipe'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: imageUrlController,
//                 decoration: InputDecoration(labelText: 'Image URL'),
//               ),
//               DropdownButtonFormField<IconData>(
//                 value: selectedIcon,
//                 items: [
//                   DropdownMenuItem(
//                     value: Icons.fastfood,
//                     child: Icon(Icons.fastfood),
//                   ),
//                   DropdownMenuItem(
//                     value: Icons.local_pizza,
//                     child: Icon(Icons.local_pizza),
//                   ),
//                   // Add more icons as needed
//                 ],
//                 onChanged: (value) {
//                   if (value != null) {
//                     selectedIcon = value;
//                   }
//                 },
//                 decoration: InputDecoration(labelText: 'Select Icon'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Update the recipe and refresh the list
//                 FoodRecipe updatedRecipe = FoodRecipe(
//                   id: recipe.id,
//                   name: nameController.text,
//                   description: descriptionController.text,
//                   imageUrl: imageUrlController.text,
//                   icon: selectedIcon,
//                 );
//                 foodRecipeController.updateRecipe(updatedRecipe);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Update'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Delete the recipe and refresh the list
//                 foodRecipeController.deleteRecipe(recipe.id!);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
