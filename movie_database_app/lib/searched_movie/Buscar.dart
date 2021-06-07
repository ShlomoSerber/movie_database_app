import 'package:flutter/material.dart';
import 'package:movie_database_app/searched_movie/MainSMovie_widget.dart';

void menuBuscar(BuildContext context, int type) {
  if (!globalUseInternet) return;

  // get search string

  String searchString;

  TextEditingController descController = TextEditingController();

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text('Cancelar'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget addButton = TextButton(
    child: Text('Buscar'),
    onPressed: () {
      Navigator.of(context).pop();

      if (searchString != null && searchString != '') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainSMovie(searchString),
          ),
        );
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Buscar'),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Buscar'),
          controller: descController,
          textAlign: TextAlign.center,
          onChanged: (String value) {
            searchString = value;
          },
          keyboardType: TextInputType.text,
        ),
      ],
    ),
    actions: [
      cancelButton,
      addButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
