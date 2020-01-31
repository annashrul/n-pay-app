import 'package:flutter/material.dart';

class NetworkFailed extends StatefulWidget {
  @override
  _NetworkFailedState createState() => _NetworkFailedState();
}

class _NetworkFailedState extends State<NetworkFailed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      home: Text('no'),
    );
  }
}
