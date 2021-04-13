// A parent widget for all the things with a changeNotifier

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
    );
  }
}
