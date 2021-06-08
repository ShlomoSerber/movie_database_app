import 'package:flutter/material.dart';
import 'package:movie_database_app/global_theme/global_theme.dart';
import 'package:movie_database_app/searched_movie/MainSMovie_widget.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();
    String query;

    return AlertDialog(
      title: Text(
        'Search',
        style: TextStyle(color: appBarColor),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: TextStyle(fontSize: width * 0.03),
            controller: controller,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              query = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Search'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainSMovie(query),
              ),
            );
          },
        ),
      ],
    );
  }
}
