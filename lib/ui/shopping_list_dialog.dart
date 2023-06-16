import 'package:flutter/material.dart';
import 'package:app_week12_s1/util/dbhelper.dart';
import 'package:app_week12_s1/models/shopping_list.dart';

class ShoppingListDialog{
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();


  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew){
    DbHelper helper = DbHelper();
    if(!isNew){
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    else {
      txtName.text = '';
      txtPriority.text = '';
    }

    return AlertDialog(
      title: Text((isNew) ? 'Nuevo elemento' : 'Edición del elemento'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),

      content: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: 'Nombre'
              ),
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Prioridad (1..3)'
              ),
            ),
            ElevatedButton(
              child: Text('Grabar'),
              onPressed: (){
                list.name = txtName.text;
                list.priority = int.parse(txtPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },)
          ],
        ),
      ),
    );
  }
}