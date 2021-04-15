import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_database_app/top_rated_movie/TRMovie_class.dart';

const String restHttp =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=0e685fd77fb3d76874a3ac26e0db8a4b&language=en-US';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  TRMovie results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: http.get(Uri.parse(restHttp)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return Center(child: Text('No hay información'));
            }

            final Map parsed = json.decode(snapshot.data.body);
            results = TRMovie.fromJson(parsed);

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(child: Text(results.results[index].title));
              },
              itemCount: results.results.length,
            );
          }),
    );
  }
}
