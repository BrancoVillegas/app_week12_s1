import 'package:app_week12_s1/models/list_items.dart';
import 'package:flutter/material.dart';
import 'package:app_week12_s1/util/dbhelper.dart';
import 'package:app_week12_s1/models/shopping_list.dart';

class ItemListDialog{
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();


  Widget buildDialog(BuildContext context, ListItem item, bool isNew){
    DbHelper helper = DbHelper();
    if(!isNew){
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;

    }
    else {
      txtName.text = '';
      txtQuantity.text = '';
      txtNote.text = '';
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
              controller: txtQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Cantidad'
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                hintText: 'Observacion'
              ),
            ),
            ElevatedButton(
              child: Text('Grabar'),
              onPressed: (){
                item.name = txtName.text;
                item.quantity = txtQuantity.text;
                item.note = txtNote.text;
                helper.insertItem(item);
                Navigator.pop(context);
              },)
          ],
        ),
      ),
    );
  }
}