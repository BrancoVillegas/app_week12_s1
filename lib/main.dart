import 'package:flutter/material.dart';
import 'package:app_week12_s1/util/dbhelper.dart';
import 'package:app_week12_s1/models/list_items.dart';
import 'package:app_week12_s1/models/shopping_list.dart';
import 'package:app_week12_s1/ui/shopping_list_dialog.dart';
import 'package:app_week12_s1/ui/items_screen.dart';

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
      home: ShowList(),
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

  ShoppingListDialog? dialog;

  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    
    //vamos a hacer un wrap
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi lista de compras!'),
      ),
      body: ListView.builder(
          itemCount: (shoppingList != null) ? shoppingList.length : 0,
          itemBuilder: (context,int index) {
            return ListTile(
              title: Text(shoppingList[index].name),
              leading: CircleAvatar(
                child: Text(shoppingList[index].priority.toString()),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        dialog!.buildDialog(context, shoppingList[index], false));
                },
              ),
              onTap: () {
                //Codigo para que muestre la ventana con los detalles del rubro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemScreen(shoppingList[index])));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog!.buildDialog(context, ShoppingList(0, '', 0), true));
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.orangeAccent,
      )
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

