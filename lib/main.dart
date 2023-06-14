import 'package:flutter/material.dart';
import 'package:app_week12_s1/util/dbhelper.dart';
import 'package:app_week12_s1/models/list_items.dart';
import 'package:app_week12_s1/models/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //DbHelper helper = DbHelper();
    //helper.testDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Week 12 S1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Show List'),
          ),
          body: ShowList(),
        ),
      ),
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList = <ShoppingList>[];

  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList.length : 0,
        itemBuilder: (context,int index) {
          return ListTile(
            title: Text(shoppingList[index].name),
          );
        }

    );
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getList();
    setState(() {
      shoppingList = shoppingList;
      print("Items: ${shoppingList.length}");
    });
  }
}

