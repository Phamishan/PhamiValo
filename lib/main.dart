import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        backgroundColor: Colors.red[700],
        centerTitle: true,
      ),
      body: const Text("yoyo"),
    ),
  ));
}
