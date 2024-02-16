import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/views/screens/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Helper/database_helper.dart';
import 'model/food_recipe_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'firebase',
      options: FirebaseOptions(
          apiKey: "AIzaSyDYbA7_Unk1Jfkxb_egAOrqfJHWk29rSAk",
          appId: "1:147312503769:android:c8fb85da79bc3b2f3b47c8",
          messagingSenderId: '147312503769',
          projectId: 'recipe-bf24c'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FoodRecipe> listData = [];

  getDataFromDB() async {
    var data = await DatabaseHelper.getItems();
    print(data);
    setState(() {
      listData = data;
      print(listData.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: (listData.isEmpty)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                      children: [
                        //Text(listData[index].title),
                        Text(listData[index].id.toString()),
                        IconButton(
                            onPressed: () async {
                              await DatabaseHelper.updateItem(
                                  listData[index].id!,
                                  'recipe',
                                  'description1');
                              getDataFromDB();
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              await DatabaseHelper.deleteItem(
                                listData[index].id!,
                              );
                              getDataFromDB();
                            },
                            icon: Icon(Icons.delete))
                      ],
                    )),
                  );
                }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              // await DatabaseHelper.createItem('title2', 'description1');
              getDataFromDB();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () async {
              var data = await DatabaseHelper.getItemById(2);
              setState(() {
                listData = data;
              });
              // getDataFromDB();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
